-- title:  tiny 5x5 fonts and editor
-- author: lb_ii
-- desc:   simple editor for 5x5 fonts with samples in Cyrillic, Latin, Greek, Hebrew and even some Japanese writings
-- script: lua

-- Tiny font's size is just 5x5 pixels.
-- It requires just 5x4 sprites/tiles.

-- Code usage sample:
--   LBFONTSTART = <TILE_ID>
--   lbprint("PRIVET, MIR;",42,100)

-- Supported letters:

-- +--UPPER MODIFIERS--+
-- |   |   |   |   |   |
-- | $ | ( | ' | ) | # |
-- |   |   |   |   |   |
-- +---+LETTER BASE+---+
-- |                   |
-- | +,-./012 3456789: |
-- | ;<=>?@AB CDEFGHIJ |
-- | KLMNOPQR STUVWXYZ |
-- |                   |
-- +--LOWER MODIFIERS--+
-- |   |   |   |   |   |
-- | ^ | [ | ` | ] | _ |
-- |   |   |   |   |   |
-- +--FONTS SWITCHERS--+
-- | abcdef ghijk      |
-- +-------------------+

-- Letter bases are mapped to 5x5 tiles,
-- which may be sprites of other letters
-- e.g. cyrillic, kana or runic stuff

-- Modifiers add extra pixels like
-- diacritic marks or just additional
-- pixels for letters bigger than 5x5,
-- e.g. 'Q' is good as "O" with "_" mod

-- Lowercase letters switches fonts,
-- e.g. "aPRIVET cIS RUSSIAN FOR HELLO"

----------------------------------------
-- copy to your code to use tiny font --
--                                    --
-- you can remove unused fonts or mods--
-- to save some code space            --
--                                    --
-- | | | | | | | | | | | | | | | | | |--
-- V V V V V V V V V V V V V V V V V V--

LBFONTSTART = 273
LBFONTCOLOR = 15
LBSPACEWIDTH= 5
LBLINESTEP  = 7
LBFONTS = {
 a = 17,
 b = 23,
 c = 97,
 d = 103,
 e = 177,
 f = 183,
 g = 273,
 h = 279,
 i = 353,
 j = 359,
 k = 433,
}
LBFONTMOD   = {
 ["$"]={0,-1},
 ["("]={1,-1},
 ["'"]={2,-1},
 [")"]={3,-1},
 ["#"]={4,-1},
 ["^"]={0, 5},
 ["["]={1, 5},
 ["`"]={2, 5},
 ["]"]={3, 5},
 ["_"]={4, 5},
}

function lbfont5x5(i,x,y)
 local c = LBFONTSTART
 local X = x-i%8*5%8
 local Y = y-i//8*5+i//16*8
 c = c+i%8*5//8+i//16%8*16
 clip(x,y,5,5)
 spr(c,X,Y,0)
 spr(c+1,X+8,Y,0)
 spr(c+16,X,Y+8,0)
 spr(c+17,X+8,Y+8,0)
end

function lbprint(str,x,y)
 local X = x-6
 for c in str:gmatch"." do
  local m = LBFONTMOD[c]
  if m ~= nil then
   clip()
   pix(X+m[1],y+m[2],LBFONTCOLOR)
		elseif c == "|" then
   X,y = x-6,y+LBLINESTEP
  elseif c == " " then
   X = X+LBSPACEWIDTH
  elseif c >= "a" then
   LBFONTSTART = LBFONTS[c]
		else
   X = X+6
   lbfont5x5(string.byte(c)-43,X,y)
  end
 end
 clip()
end

-- ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^--
-- | | | | | | | | | | | | | | | | | |--
--                                    --
-- copy to your code to use tiny font --
----------------------------------------

----------------------------------------
-- here goes code specific to editor, --
-- you don't need it                  --
----------------------------------------

LANG={
  {
    id = "Russian",
				linestep = 7,
				spacing = 5,
    offset = 17,
    samples = {
      {"SXEW- EW_E() JTIH M@GKIH FRANC_U3SKIH BULOK,|  DA VYPEI' ZE 4AQ;",0,62},
      {"BYSTRA@ RYZA@ LISA PEREPRYGNULA 4ERE3|  LENIVUQ SOBAKU...",0,80},
      {"JI', ZLOB; GDE TU3? PR@4- QNYH SXEMW_IC_ V|  WKAF.",0,99},
      {"V 4AW_AH QGA ZIL BY CITRUS?;|  DA <NO FAL-WIVYI' JK3EMPL@R>",0,117},
    }
  },
  {
    id = "Russian Bold",
				linestep = 7,
				spacing = 5,
    offset = 23,
    samples = {
      {"SXEW- EW_E() JTIH M@GKIH FRANC_U3SKIH BULOK,|  DA VYPEI' ZE 4AQ;",0,62},
      {"BYSTRA@ RYZA@ LISA PEREPRYGNULA 4ERE3|  LENIVUQ SOBAKU...",0,80},
      {"JI', ZLOB; GDE TU3? PR@4- QNYH SXEMW_IC_ V|  WKAF.",0,99},
      {"V 4AW_AH QGA ZIL BY CITRUS?;|  DA <NO FAL-WIVYI' JK3EMPL@R>",0,117},
    }
  },
  {
    id = "Old-Slavic and Ukranian",
				linestep = 7,
				spacing = 5,
    offset = 17,
    samples = {
      {"NO4I VX PL@SKAHX, VO3L/'@N-@HX",0,70},
      {"DA UT+(HAHX PLOTSKIHX,",118,80},
      {"NOVYE M/'RY SUL@TX VAMX GRE()3Y KISLOVODSKA;;;",0,90},
      {"4U=W /()H, DOC_Q, GA?|  KUMEDNA Z TI, PROW_AI'S@ BE3 G#OL-F/'V;",0,110},
    }
  },
  {
    id = "Old-Slavic and Ukranian Bold",
				linestep = 7,
				spacing = 5,
    offset = 23,
    samples = {
      {"NO4I VX PL@SKAHX, VO3L/')@N-@HX",0,70},
      {"DA UT+('HAHX PLOTSKIHX,",118,80},
      {"NOVYE M/')RY SUL@TX VAMX GRE()3Y KISLOVODSKA;;;",0,90},
      {"4U=W /(#H, DOC_Q, GA?|  KUMEDNA Z TI, PROW_AI'S@ BE3 G#OL-F/')V;",0,110},
    }
  },
  {
    id = "English",
				linestep = 7,
				spacing = 5,
    offset = 97,
    samples = {
      {"HOW I WANT A DRINK, ALCOHOLIC OF COURSE,|  AFTER THE HEAVY LECTURES INVOLVING|  O_UANTUM MECHANICS..",0,62},
      {"JACKDAWS LOVE MY BIG SPHINX OF O_UARTZ.",0,88},
      {"O_UICK BROWN FOX JUMPS OVER THE LAZY DOG.",0,99},
      {"LOREM IPSUM DOLOR SIT AMER, CONSECTUR|  ADIPISCING ELIT, SED DO EIUSMOD TEMPOR|  INCIDICUNT UT LABORE ET DOLORE MAGNA|  ALIO_UA. UT ENIM AD MINIM VENIAM, ...",0,109},
    }
  },
  {
    id = "English Bold",
				linestep = 7,
				spacing = 5,
    offset = 103,
    samples = {
      {"HOW I WANT A DRINK, ALCOHOLIC OF COURSE,|  AFTER THE HEAVY LECTURES INVOLVING|  O_UANTUM MECHANICS..",0,62},
      {"JACKDAWS LOVE MY BIG SPHINX OF O_UARTZ.",0,88},
      {"O_UICK BROWN FOX JUMPS OVER THE LAZY DOG.",0,99},
      {"LOREM IPSUM DOLOR SIT AMER, CONSECTUR|  ADIPISCING ELIT, SED DO EIUSMOD TEMPOR|  INCIDICUNT UT LABORE ET DOLORE MAGNA|  ALIO_UA. UT ENIM AD MINIM VENIAM, ...",0,109},
    }
  },
  {
    id = "Espanol",
				linestep = 7,
				spacing = 5,
    offset = 97,
    samples = {
      {"O_UIERE LA BOCA EXHAUSTA VID, KIWI PIN'A|  Y FUGAZ JAMO'N.",0,62},
      {"WHISKY BUENO:|         /EXCITAD MI FRA'GIL PEO_UEN'A;",0,81},
      {"EL VELOZ MURCIE'LAGO HINDU' COMI'A FELIZ|  CARDILLO Y KIWI. LA CIGU()EN'A TOCABA EL|  SAXOFO'N DETRA'S DEL PALENO_UE DE PAJA.",0,99},
    }
  },
  {
    id = "Espanol Bold",
				linestep = 7,
				spacing = 5,
    offset = 103,
    samples = {
      {"O_UIERE LA BOCA EXHAUSTA VID, KIWI PIN'A|  Y FUGAZ JAMO'N.",0,62},
      {"WHISKY BUENO:|         /EXCITAD MI FRA'GIL PEO_UEN'A;",0,81},
      {"EL VELOZ MURCIE'LAGO HINDU' COMI'A FELIZ|  CARDILLO Y KIWI. LA CIGQ()EN'A TOCABA EL|  SAXOFO'N DETRA'S DEL PALENO_UE DE PAJA.",0,99},
    }
  },
  {
    id = "Greek and Math",
				linestep = 7,
				spacing = 5,
    offset = 177,
    samples = {
      {"CESKEPA)ZW THN( VYXOFQO)RA BDELYGMI)A.",8,80},
      {"DY/DX = 2A@X + 12@B",8,100},
      {"U = 3,141592653589793238462643383279...",8,120},
    }
  },
  {
    id = "Hebrew",
				linestep = 7,
				spacing = 5,
    offset = 273,
    samples = {
      {"                  16 16 :Z=T, Z=T UVMW",4,75},
      {"WIA , VNMM VTQ[L( , EVEI EVC RWA RBDE EZ",4,90},
      {", OKIUWPN RPSM -( UL(GL(GL( RMJ . VL(KA IPL(",4,100},
      {"                   VHQ[U VL(EAB RWAL( WIA",4,110},
    }
  },
  {
    id = "Hebrew Bold",
				linestep = 7,
				spacing = 5,
    offset = 279,
    samples = {
      {"                  16 16 :Z=T, Z=T UVMW",4,75},
      {"WIA , VNMM VTQ[L( , EVEI EVC RWA RBDE EZ",4,90},
      {", OKIUWPN RPSM -( UL(GL(GL( RMJ . VL(KA IPL(",4,100},
      {"                   VHQ[U VL(EAB RWAL( WIA",4,110},
    }
  },
  {
    id = "Runic",
				linestep = 7,
				spacing = 5,
    offset = 183,
    samples = {
      {"HOW I WANT A DRINK, ALCOHOLIC OF COURSE,|  AFTER THE HEAVY LECTURES INVOLVING|  QUANTUM MECHANICS..",0,62},
      {"JACKDAWS LOVE MY BIG SPHINX OF QUARTZ.",0,88},
      {"QUICK BROWN FOX JUMPS OVER THE LAZY DOG.",0,99},
      {"LOREM IPSUM DOLOR SIT AMER, CONSECTUR|  ADIPISCING ELIT, SED DO EIUSMOD TEMPOR|  INCIDICUNT UT LABORE ET DOLORE MAGNA|  ALIQUA. UT ENIM AD MINIM VENIAM, ...",0,109},
    }
  },
  {
    id = "Hiragana",
				linestep = 8,
				spacing = 6,
    offset = 359,
    samples = {
      {"+' 0 5' : ? D I' N Q) V",0,70},
      {", 1 6 ;' @ E J   R Y",0,79},
      {"- 2 7) < A_ F' K( O S X",0,88},
      {". 3 8 = B G L   T Z`^_('$",0,97},
      {"/( 4 9 > C H M( P U W(",0,106},
      {",|U|D|@|H|G|>",230,70},
      {";'|R|A_|S|W(",219,70},
      {"V|0|P|:|T|9",208,70},
						{"<|B|?|Q)|K(",197,70},
						{"-|Y|C|/(|2|P|I'",186,70},
						{"3|F'|4|.|=",175,70},
						{"+'|5'|1|O|L|J|6",164,70},
						{"Z`^_('$|E|M(|8|7)",153,70},
    }
  },
  {
    id = "Katakana",
				linestep = 8,
				spacing = 6,
    offset = 353,
    samples = {
--       akasatanahamayarawa
      {"+ 0 5 :( ? D I N Q V",0,70}, --a
      {", 1 6 ; @ E J   R Y",0,79}, --i
      {"- 2 7 < A F K O S X",0,88}, --u
      {". 3 8 = B G L   T Z",0,97}, --e
      {"/ 4 9 > C H M P U W",0,106},--o
      {",|U|D|@|H|G|>",230,70},
      {";|R|A|S|W",219,70},
      {"V|0|P|:(|T|9",208,70},
						{"<|B|?|Q|K",197,70},
						{"-|Y|C|/|2|P|I",186,70},
						{"3|F|4|.|=",175,70},
						{"+|5|1|O|L|J|6",164,70},
						{"Z|E|M|8|7)",153,70},
    }
  },
  {
    id = "Basic Kanji and Punctuation",
				linestep = 8,
				spacing = 6,
    offset = 433,
    samples = {
      {" 2B^[_2/#+7O(]|A   5|B^[_   6|C   7|D 1 8|E 2 9|F'^[`]_ 3 1+|G 4 1+1",0,64},
      {"2/#6L()'$#^[`]_MNj0k-jH6,,:k-j?k?;",60,70},
      {"k<J()j0RI'8Xk>j>,kZj=k,VjI'6:k...",60,80},
      {"k<i,X:(kKiB'kYi>k>=cINTERNETk",60,120},
      {" S|P(Q'`R(| T",60,92},
      {"Hj5',k|Ij1,k",100,92},
      {"X UjSk|0 VjSk|X WjLSk",200,92},
    }
  },
}

ID=0

DECORATOR = {
  {id="" ,dots={}},
  {id="_",dots={{4,5}}},
  {id="(",dots={{1,-1}}},
  {id="'",dots={{2,-1}}},
  {id=")",dots={{3,-1}}},
  {id="()",dots={{1,-1},{3,-1}}},
}
DID=1

function getadr(chr,i,j)
  c   = LBFONTSTART+(chr%8*5+i)//8
  c   = c+(chr//8*5+j)//8*16
  ci  = (chr%8*5+i)%8
  cj  = (chr//8*5+j)%8
  return 0x8000+ci+cj*8+c*64
end

function buttons(idx)
  if btnp(7) then
    ID = ID<#LANG and ID+1 or 0
  end
  if ID == 0 then
		  return
		end

  if btnp(0) and idx.i>=idx.w then
    idx.i = idx.i - idx.w
  end
  if btnp(1) and idx.i<idx.w*(idx.h-1) then
    idx.i = idx.i + idx.w
  end
  if btnp(2) and idx.i>0 then
    idx.i = idx.i - 1
  end
  if btnp(3) and idx.i<idx.w*idx.h-1 then
    idx.i = idx.i + 1
  end
  if btnp(4) then
    MODE = 3 - MODE
  end
  if btnp(5) and MODE==2 then
    local i = IDX[2].i%5
    local j = IDX[2].i//5
    local a = getadr(IDX[1].i,i,j)
    poke4(a,15-peek4(a))
  end
  if btnp(6) then
    DID = DID<#DECORATOR and DID+1 or 1
  end
end

IDX = {{i=0,w=8,h=6},{i=0,w=5,h=5}}
MODE = 1

function showletters()
  local x = 0
  local y = 10
  print("all letters",x+2,2)
  for i=0,7 do
    for j=0,5 do
      rectb(x+i*8,y+j*8,9,9,15)
      lbprint(string.char(43+i+j*8),x+2+i*8,y+2+j*8)
    end
  end
  rectb(x+IDX[1].i%8*8,y+IDX[1].i//8*8,9,9,2)
  if MODE == 1 then
    rectb(x,y,8*8+1,8*6+1,2)
  end
end

function showeditor()
  local x = 108

  local y = 18
  print("code \""..string.char(43+IDX[1].i)..DECORATOR[DID].id.."\"",x,2)
  for i=0,4 do
    for j=0,4 do
      if peek4(getadr(IDX[1].i,i,j))~=0 then
        rect(x+i*8,y+j*8,9,9,15)
      end
      rectb(x+i*8,y+j*8,9,9,15)
    end
  end
  for _,d in pairs(DECORATOR[DID].dots) do
    rect(x+d[1]*8,y+d[2]*8,9,9,15)
  end
  if MODE == 2 then
    rectb(x,y,8*5+1,8*5+1,2)
    rectb(x+IDX[2].i%5*8,y+IDX[2].i//5*8,9,9,2)
  end
end

function showresult()
  local x = 191
  local y = 25
  print("result",x+4,y-9)
  rectb(x,y,42,34,15)
  for i=0,4 do
    for j=0,3 do
      spr(LBFONTSTART+i+j*16,x+1+i*8,y+1+j*8)
    end
  end
end

function showusage()
  print("   A ->",72,2)
  print("S -> language",168,2)
  print("<- Z ->",72,32)
  print("   X ->",72,40)
end

function showsamples()
  for _,s in pairs(LANG[ID].samples) do
    lbprint(s[1],s[2],s[3])
  end
end

function TIC()
  cls(0)
  if ID>0 then
    LBFONTSTART = LANG[ID].offset
    LBLINESTEP  = LANG[ID].linestep
    LBSPACEWIDTH= LANG[ID].spacing
    showletters()
    showeditor()
    showresult()
    showusage()
    showsamples()
  else
				LBLINESTEP  = 7
    LBSPACEWIDTH= 5
		  lbprint("aPRIV/'T, SV/'T;",40,100)
		  lbprint("bPRIVET, MIR;",20,20)
		  lbprint("c/HOLA, MUNDO;",60,60)
		  lbprint("dHELLO, WORLD;",120,35)
		  lbprint("eGEIA) SOY, KO'SME;",110,80)
		  lbprint("g;OL(VJ OVL(W",170,110)
		  lbprint("iDUkK:iVkKiS>k-",160,15)
				LBLINESTEP  = 8
		  lbprint("j4|X|@|;'|D|k,j|8|0|,|k;",10,45)
    if time()//500%2==0 then
  		  lbprint("cPRESS S TO START",70,125)
				end
  end
  buttons(IDX[MODE])
end
