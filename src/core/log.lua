-- requires utils.lua
logger=class:extend({
	filename="log/log",
	log=function(self,text,overwrite) 
		local t = (type(t)=="table") and serialize(text) or tostr(text)
		printh(t,self.filename,overwrite)
	end
})