trigger SOA_CountRelatedContactTrgr on Contact (after insert, after update, after delete, after undelete) {
    SOA_CountRelatedContactHdlr.handleTrigger(Trigger.new, Trigger.old, Trigger.oldMap, Trigger.operationType);
}