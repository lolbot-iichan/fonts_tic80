from PIL import Image
from PIL import ImageDraw
from PIL import ImageFont
rgb = Image.open("sprites.gif").convert("RGB")

sheets = {
    "ciryllic":(8,8,{"+":"(","C":"_"},("E()","I'","W_","/'","/()","G#",)),
    "ciryllic_bold":(56,8,{"+":"('","C":"_"},("E()","I'","W_","/('","/$)","G#",)),
    "latin":(8,48,{},("O_","N'","A'","E'","I'","O'","U'","U()","C`")),
    "latin_bold":(56,48,{},("O_","N'","A'","E'","I'","O'","Q'","Q()","C`")),
    "greek":(8,88,{},()),
    "greek_math":(56,88,{"B":"[","C":"_","D":"')","H":"_"},()),
    "hebrew":(8,136,{"L":"(","@":"]","F":"_","Y":"`","X":"_"},()),
    "hebrew_bold":(56,136,{"L":"(","@":"]","F":"_","Y":"[","X":"_"},()),
    "japanese_katakana":(8,176,{":":"("},()),
    "japanese_hiragana":(56,176,{"+":"'","/":"(","5":"'","7":")",";":"'","A":"_","F":"'","I":"'","K":"(","M":"(","Q":")","W":"(","Z":"'^_(`$",},()),
    "japanese_other":(8,216,{"/":"#","B":"^[_","F":"'^[`]_","J":"()","L":"()'$#^[`]_","O":"(]","P":"(","R":"(",},()),
    "runic_slavic":(56,216,{},()),
}

extras = {
 "$": (0,-1),
 "(": (1,-1),
 "'": (2,-1),
 ")": (3,-1),
 "#": (4,-1),
 "^": (0,5),
 "[": (1,5),
 "`": (2,5),
 "]": (3,5),
 "_": (4,5),
}

font = ImageFont.truetype("times.ttf", 14)

for c in sheets:
    out = Image.new("RGB",(300,420+(len(sheets[c][3])+7)//8*70),(255,255,255))
    for j in range(6):
        for i in range(8):
            I,J,ch = i,j,chr(43+i+j*8)
            ext = sheets[c][2][ch] if ch in sheets[c][2] else ""
            for y in range(5):
                for x in range(5):
                    if  sum(rgb.getpixel((sheets[c][0]+I*5+x,sheets[c][1]+J*5+y)))>100:
                        for ii in range(4):
                            for jj in range(4):
                                out.putpixel((10+i*35+x*4+ii,40+j*70+y*4+jj),(0,0,0))
            for x,y in [extras[e] for e in ext]:
                for ii in range(4):
                    for jj in range(4):
                        out.putpixel((10+i*35+x*4+ii,40+j*70+y*4+jj),(192,0,0))
            ImageDraw.Draw(out).text((15+i*35,15+j*70),ch+ext,(0,0,0),font=font)
    for k,chx in enumerate(sheets[c][3]):
        i,j,I,J,ch = k%8,6+k/8,(ord(chx[0])-43)%8,(ord(chx[0])-43)/8,chx[0]
        for y in range(5):
            for x in range(5):
                if  sum(rgb.getpixel((sheets[c][0]+I*5+x,sheets[c][1]+J*5+y)))>100:
                    for ii in range(4):
                        for jj in range(4):
                            out.putpixel((10+i*35+x*4+ii,40+j*70+y*4+jj),(0,0,0))
        for x,y in [extras[e] for e in chx[1:]]:
            for ii in range(4):
                for jj in range(4):
                    out.putpixel((10+i*35+x*4+ii,40+j*70+y*4+jj),(192,0,0))
        ImageDraw.Draw(out).text((15+i*35,15+j*70),chx,(0,0,0),font=font)
    out.save("../sheets/"+c+".png")