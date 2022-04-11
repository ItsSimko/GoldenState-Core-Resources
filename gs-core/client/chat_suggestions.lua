TriggerEvent('chat:addSuggestion', '/wire', 'This command will transfer money from your bank account to the server id given.', {
    { name="playerId", help="To wire transfer directly to someone place their Server ID here." },
    { name="Amount", help="The amount you wish to wire transfer to the playerId player provided" },
})