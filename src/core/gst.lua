-- gst: Game State manager for Pico8
__gstc={cur=nil}
function gst(k) return gstt(k) end
function gstt(k,on,off)
  if(k!=nil) then
    local f=function()end
    __gstc[k]=__gstc[k] or {key=k, on=f,off=f}
    if(on)__gstc[k].on=on 
    if(off)__gstc[k].off=off 
    local o=__gstc.cur
    if(o)__gstc[o].off(o,k)
    __gstc.cur=k
    __gstc[k].on(o,k)
  end
  return __gstc.cur
end
function gstc(c)
  __gstc=c
  __gstc.cur=__gstc.cur or nil 
end