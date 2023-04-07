local Types = require(script.Parent.Types)
local RunService = game:GetService("RunService")

assert(RunService:IsServer())

local SmartTool = {}
SmartTool.__index = SmartTool

function SmartTool.new(Tool: Tool)
	assert(Tool:IsA("Tool"),"Expected a Tool as the first argument!")

	local self = setmetatable({},SmartTool)

	local Events: Folder = Tool:FindFirstChild("Events") or Instance.new("Folder")
	Events.Name = "Events"
	Events.Parent = Tool

	self.EventsFolder = Events

	return self
end

function SmartTool:NewEvent(Name: string): RBXScriptSignal
	local Event: RemoteEvent = Instance.new("RemoteEvent")
	Event.Name = Name
	Event.Parent = self.EventsFolder

	return Event.OnServerEvent
end

function SmartTool:OnEvent(Name: string): RBXScriptSignal?
	local Event: RemoteEvent = self:GetEvent(Name)
	assert(Event:IsA("RemoteEvent"),"Couldn't find event!")

	return Event.OnClientEvent
end

function SmartTool:FireEvent(Name: string, Player: Player, ...)
	local Event: RemoteEvent = self:GetEvent(Name)
	assert(Event:IsA("RemoteEvent"),"Couldn't find event!")

	Event:FireClient(Player, ...)
end

return SmartTool :: Types.Server