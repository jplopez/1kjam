-- simple collision functions for rectangles and circles
-- Requires oop.lua
collision_engine=class:extend({

  --side constants
  _top=2,
  _bottom=3,
  _left=7,
  _right=11,
  _top_left=9,  -- top + left
  _top_right=13, -- top + right
  _bottom_left=10, -- bottom + left
  _bottom_right=14, -- bottom + right

  tolerance=1,

  --[[
    Checks if obj1 and obj2 are colliding. This functions infers if objs are
    circle or rect based on their attributes.
    * Rectangles: x,y,w,h
    * Circle: x,r 
  ]]
  colliding=function(_END,obj1,obj2)
    if(obj1.r) then
      if(obj1.r) return is_circle_colliding(_ENV,obj1,obj2)
    elseif(obj2.r) then
      return is_circle_rect_colliding(_ENV,obj2,obj1)
    end
    return is_rect_colliding(_ENV,obj1,obj2)
  end,

  is_circle_colliding=function(_ENV,c1,c2)
    local dx=c1.x-c2.x
    local dy =c1.y-c2.y
    local distance=sqrt(dx*dx + dy*dy)
    return distance<c1.r+c2.r+tolerance
  end,

  --[[
    Check if circle is withing the bounds of the rect
    Returns boolean if circle is out of bounds and the 
    value for side of collision 
  ]]
  is_circle_rect_oob=function(_ENV,c,rect)
    local tol,side=tolerance+c.r,nil
    if(c.y-rect.y<=tol) side=_top
    if((rect.y+rect.h)-c.y<=tol) side=_bottom
    if(side==nil) then
      if(c.x-rect.x<=tol) side=_left
      if((rect.x+rect.w)-c.x<=tol) side=_right
    end
    return side!=nil, side
  end,

  --[[
    Checks if a circle and a rectangle are colliding.
    Returns boolean for collision, and a number representing
    the side of the collision on the rectangle.
    side values are defined in globals
  ]]
  is_circle_rect_colliding=function(_ENV,c,rec)
    local closest_x=mid(rec.x, c.x, rec.x+rec.w)
    local closest_y=mid(rec.y, c.y, rec.y+rec.h)
    local tol=c.r+tolerance

    local dx=c.x-closest_x
    local dy=c.y-closest_y
    local coll=dx*dx + dy*dy < tol*tol
    local side=nil
    --determine side of collision in rect
    if coll then
      if(dx<0) side=_left
      if(dx>0) side=_right
      if(dx==0 or abs(dy)<abs(dx)) then
        if(dy<0) side=_top
        if(dy>0) side=_bottom
      else  --corner
        if(dy<0) side=_top+side
        if(dy>0) side=_bottom+side
      end
    end
    return coll,side
  end,

  is_rect_colliding=function(_ENV,rect1,rect2)
    return rect1.x < rect2.x + rect2.w + tolerance
        and rect1.x + rect1.w > rect2.x - tolerance
        and rect1.y < rect2.y + rect2.h + tolerance
        and rect1.y + rect1.h > rect2.y - tolerance
  end,

  -- utility function to print sides as strings
  print_side=function(_ENV,side)
    if(side==nil) return ""
    if(side==_top_left) return "top-left"
    if(side==_top) return "top"
    if(side==_top_right) return "top-right"
    if(side==_left) return "left"
    if(side==_right) return "right"
    if(side==_bottom_left) return "bottom-left"
    if(side==_bottom) return "bottom"
    if(side==_bottom_right) return "bottom-right"
  end
})