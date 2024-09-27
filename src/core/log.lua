-- requires utils.lua
logger=class:extend({
	filename="log",
	log=function(self,text,overwrite) 
		local txt = (type(text)=="table") and serialize(text) or tostr(text)
		printh(txt,self.filename,overwrite)
	end
})