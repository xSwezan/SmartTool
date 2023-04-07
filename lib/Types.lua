local Types = {}

export type Client = {
	new: (Tool: Tool) -> Client;

	GetEvent: (self: Client, Name: string) -> RemoteEvent?;
	OnEvent: (self: Client, Name: string) -> RBXScriptSignal?;
	FireEvent: (self: Client, Name: string, Arguments...) -> nil;
}

export type Server = {
	new: (Tool: Tool) -> Server;

	NewEvent: (self: Server, Name: string) -> RBXScriptSignal;
	OnEvent: (self: Server, Name: string) -> RBXScriptSignal?;
	FireEvent: (self: Server, Name: string, Player: Player, Arguments...) -> nil;
}

return Types