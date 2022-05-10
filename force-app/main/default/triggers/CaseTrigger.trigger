trigger CaseTrigger on Case (after insert) {
    List<CreateTask__e> eventsToPublish = new List<CreateTask__e>();
    for (Case curCase : trigger.new) {
		CreateTask__e newEvent = new CreateTask__e(Case_ID__c = curCase.Id, Policy_ID__c = curCase.Policy__c);
    }
    for (CreateTask__e event : eventsToPublish) {
        EventBus.publish(event);
    }
}