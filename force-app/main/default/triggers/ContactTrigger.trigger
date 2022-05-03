/*
Created by: Rachel Galang
Description: Before insert Contact trigger that links
a contact to any account with a matching phone number.
*/
trigger ContactTrigger on Contact (before insert) {
    ContactHandler.LinkToAccount(trigger.new);
}