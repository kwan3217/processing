import subprocess
import os
import re

position=re.compile(r"!--Position: ([A-Za-z0-9_]+) \(([0-9]+),([0-9]+)\)")
bbox_height=re.compile(r"<svg.*height='([0-9]+(.[0-9]+)?)pt'")
bbox_width =re.compile( r"<svg.*width='([0-9]+(.[0-9]+)?)pt'")

def tex_head(oufn):
    ouf=open(oufn+'.tex','w')
    ouf.write("\\documentclass{minimal}\n")
    ouf.write("\\usepackage[user,pagelayout,savepos]{zref}\n")
    ouf.write("\\begin{document}\n")
    ouf.write("$$\n")
    return ouf

def tex_eqn(ouf,tag,text):
    ouf.write("\\zsavepos{"+tag+"}{"+text+"}\n")

def tex_foot(ouf,tags):
    ouf.write("$$\n")
    for tag in tags:
        ouf.write("\\typeout{!--Position: "+tag+" (\\zposx{"+tag+"},\\zposy{"+tag+"})}\n")
    ouf.write("\\end{document}\n")
    ouf.close()

def tex_render(oufn):
    # Get the coordinates of the piece by itself
    subprocess.call("latex "+oufn+".tex > /dev/null",shell=True)
    subprocess.call("latex "+oufn+".tex | grep \"!--Position:\" > "+oufn+".coords",shell=True)
    # Delete the .tex since we no longer need it
    os.remove(oufn+'.tex')
    # clean up other files we don't care about
    os.remove(oufn+'.aux')
    os.remove(oufn+'.log')
    # Parse the coords
    with open(oufn+'.coords',"r") as inf:
        content=inf.readlines()
    os.remove(oufn+'.coords')
    content=[x.strip() for x in content]
    coords={}
    for line in content:
        m=position.search(line)
        coords[m.group(1)]=(int(m.group(2)),int(m.group(3)))
    # Render the piece
    subprocess.call("dvisvgm -e -n -bmin --keep "+oufn+".dvi > /dev/null 2>&1",shell=True)
    # Delete the DVI now that it is rendered
    os.remove(oufn+'.dvi')
    # Slurp the SVG for this equation
    with open(oufn+'.svg',"r") as inf:
        content=inf.readlines()
    # Delete the SVG
    os.remove(oufn+'.svg')
    return (coords,content)

class subexpr:
    def __init__(self,name,tex):
        self.name=name
        self.tex =tex
        ouf=tex_head(name)
        tex_eqn(ouf,name,tex)
        tex_foot(ouf,[name])
        (self.coords,self.svg)=tex_render(name)
    def draw(self,coords,fade):
        print("Drawing "+self.name+" at coords: ",coords," fade: ",fade)

class expr:
    def __init__(self,names,texes):
        ouf=tex_head('whole')
        self.subexprs={}
        for name,tex in zip(names,texes):
            self.subexprs[name]=subexpr(name,tex)
            tex_eqn(ouf,name,tex)
        tex_foot(ouf,names)
        (self.coords,self.svg)=tex_render('whole')
        for k,v in self.coords.items():
            print(k,v)
        for line in self.svg:
            m=bbox_width.search(line)
            if m:
                self.width=float(m.group(1))
                m=bbox_height.search(line)
                self.height=float(m.group(1))
                break

class dance_eqn:
    def normalize_parts(self):
        totalWidth_sp=self.exprA.coords["__last__"][0]-self.exprA.coords["__first__"][0]
        totalWidth_svg=self.exprA.width
        ratio=totalWidth_sp/totalWidth_svg
        #At this point, all the terms have matching names, so we can get the 
        #coefficients for a linterp from one to the other
        self.m={}
        self.b={}
        for k,v in self.exprA.coords.items():
            self.m[k]=(self.exprB.coords[k][0]-v[0],self.exprB.coords[k][1]-v[1])
            self.b[k]=self.exprA.coords[k]
        #Adjust so that the equals doesn't move
        equals_m=self.m["equals"]
        for k in self.m:
            self.m[k]=(self.m[k][0]-equals_m[0],self.m[k][1]-equals_m[1])
        #scale all the M and B down to SVG
        for k in self.m:
            self.m[k]=(self.m[k][0]/ratio,self.m[k][1]/ratio)
            self.b[k]=(self.b[k][0]/ratio,self.b[k][1]/ratio)
        #Set the equals to its proper position
        equals_b=self.b["equals"]
        for k in self.b:
            self.b[k]=(self.b[k][0]-equals_b[0]+self.xeq,self.b[k][1]-equals_b[1]+self.yeq)


class dance_addsub_left_right(dance_eqn):
    def __init__(self,
                 left_before ,left_sign ,term,left_after ,
                 equals,
                 right_before,right_sign,     right_after,
                 xeq,yeq):
        """
        Render the movement of a term from the left side to the right side.
    
        :param left_before:  Part of equation on the left side to the left of 
                             (before) the term to be moved, in TeX format
        :type  left_before:  string
        :param left_sign:    Sign of the term to be moved when it is on the left side
        :type  left_sign:    string
        :param term:         Term to be moved
        :type  term:         string
        :param left_after:   Part of equation on the left side to the right of 
                             (after) the term to be moved
        :type  left_after:   string
        :param equals:       Anchor of expression, usually equals. This will remain 
                             in the same place
        :type  equals:       string
        :param right_before: Part of equation on the right side to the left of 
                             (before) the term to be moved, in TeX format
        :type  right_before: string
        :param right_sign:   Sign of the term to be moved when it is on the right side
        :type  right_sign:   string
        :param right_after:  Part of equation on the right side to the right of 
                             (after) the term to be moved
        :type  right_after:  string
        :param xeq:          X coordinate of equals sign
        :type  xeq:          int
        :param yeq:          Y coordinate of equals sign
        :type  yeq:          int
        :param frames:       Number of frames to use in animation
        :type  frames:       int
        """
        self.xeq=xeq
        self.yeq=yeq
        # Get the spacing of the equation before the move
        self.exprA=expr(["__first__","left_before",     "sign","term","left_after","equals","right_before","right_after","__last__"],
                        [""         , left_before , left_sign , term , left_after , equals , right_before , right_after, ""        ])
        # Get the spacing of the equation after the move
        self.exprB=expr(["__first__","left_before","left_after","equals","right_before",      "sign","term","right_after","__last__"],
                        [""         , left_before , left_after , equals , right_before , right_sign , term , right_after ,""        ])
        self.normalize_parts()
        
    def get_piece_coords(self,k,t):
        return (self.b[k][0]+self.m[k][0]*t,self.b[k][1]+self.m[k][1]*t)

    def draw_piece(self,k,t,fade=1):
        if k=='sign':
            self.exprA.subexprs["sign"].draw(self.get_piece_coords(k,t),(1-t)*fade)
            self.exprB.subexprs["sign"].draw(self.get_piece_coords(k,t),(  t)*fade)
        else:
            self.exprA.subexprs[k].draw(self.get_piece_coords(k,t),fade)

    def draw(self,t,fade=1):
       for k in self.m:
           self.draw_piece(k,t,fade)
            
d=dance_addsub_left_right("1","+","1","","=","2","-","",100,100)
d.draw(0.0)
d.draw(0.5)
d.draw(1.0)
print(d.get_piece_coords("sign",0.5))
print(d.get_piece_coords("sign",1.0))


