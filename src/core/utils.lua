-- String, Print and Table manipulation utilities

function is_empty(str) return str==nil or str=="" end

-- print centered
function printc(str,y,clr)
  local x=64-(#str*4)/2
  print(str,x,y,clr)
end
   
-- print shadow
function prints(str,x,y,clr)
  print(str,x+1,y+1,7)
  print(str,x,y,clr)
end

-- print outlined
function printo(s,x,y,c,o) -- 34 tokens, 5.7 seconds
  color(o)
  ?'\-f'..s..'\^g\-h'..s..'\^g\|f'..s..'\^g\|h'..s,x,y
  ?s,x,y,c
end

-- left padding
function pad(str,len,char)
  str=tostr(str)
  char=char or "0"
  if (#str==len) return str
  return char..pad(str,len-1)
end

function spaces(len)
  if(len==0) return ""
  return " "..spaces(len-1)
end

function table_concat(array,sep)
  if(array==nil or #array==0) return ""
  sep=sep or ","
  local res=""
  for i=1,#array do
    res=res..array[i]
    if(i<#array) res=res..sep
  end
  return res
end

function serialize(tbl,l)
  if(tbl==nil) then return "" end
  l=l or 0
  local res={}
  for k,v in pairs(tbl) do
    local fld=""
    if type(v)=="string" then
      fld=tostr(k)..' : "'..v..'"'
    elseif type(v)=="function" then
      fld=tostr(k)..' : "function"'
    elseif type(v)=="table" then 
      fld=tostr(k)..' :\n'..serialize(v,l+1)
    else 
      fld=tostr(k)..' : '..tostr(v)
    end 
    add(res,spaces(2*(l+1))..fld)
  end 
  return spaces(2*l)..'{\n'..
        table_concat(res,"\n")..
        '\n'..spaces(2*l)..'}'
end