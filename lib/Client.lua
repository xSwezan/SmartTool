local Types = require(script.Parent.Types)
local RunService = game:GetService("RunService")

assert(RunService:IsClient())

local SmartTool = {}
SmartTool.__index = SmartTool

function SmartTool.new(Tool: Tool)
	assert(Tool:IsA("Tool"),"Expected a Tool as the first argument!")

	local self = setmetatable({
		EventsFolder = Tool:WaitForChild("Events");
	},SmartTool)

	return self
end

function SmartTool:GetEvent(Name: string): RemoteEvent?
	return self.EventsFolder:WaitForChild(Name,3)
end

function SmartTool:OnEvent(Name: string): RBXScriptSignal?
	local Event: RemoteEvent = self:GetEvent(Name)
	assert(Event:IsA("RemoteEvent"),"Couldn't find event!")

	return Event.OnClientEvent
end

function SmartTool:FireEvent(Name: string, ...)
	local Event: RemoteEvent = self:GetEvent(Name)
	assert(Event:IsA("RemoteEvent"),"Couldn't find event!")

	Event:FireServer(...)
end

return SmartTool :: Types.Client