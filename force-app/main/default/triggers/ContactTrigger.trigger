trigger ContactTrigger on Contact (before insert) {
    ContactHandler.LinkToAccount(trigger.new);
}