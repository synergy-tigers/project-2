# Project 2: Insuraforce

## Core Declarative Requirements

### Data Model
  * `All` Create ERD 
  
### Security
  * `All` Org level security for at least two distinct profiles 
  * `All` Object level security for at least three distinct user types 
  * `All` Record-level security & access should be configured for the organization 
  * `All` Field-level security 

### Declarative UI
  * `Rama` `Kevin` One custom app with a custom home page (Insuraforce) 
  * `Kevin` Custom and standard objects should have configured layouts 

### Process Automation
  * `Rachel` Screen Flow 
    - An order screen flow placed on the Account records detail page that allows one to create multiple orders
  * `Jonathan` Before-save Flow 
    - When an Opportunity record is created, change stage to prospecting
  * `Kevin` After-save Flow 
    - Create an order from an opportunity
    - Create a policy from an order
  * `Not Assigned` Autolaunched Flow 

### Reports & Dashboards
  * At least one standard and one custom report ![Andy](https://img.shields.io/badge/-Andy-yellow)

## Core Programmatic Requirements
  
### Apex Testing
  * Ensure that Apex code has adequate test coverage and follow testing best practices both individually and as a team
    - [ ] Andy
    - [ ] Jonathan
    - [ ] Kevin
    - [ ] Rachel
    - [ ] Rama

### Apex Triggers
  * `Not Assigned` Accounts can't have more than one health insurance policy. Trying to add more than one health insurance product should trigger an error 
  * `Rachel` Relate a Contact to an Account if the contact has the same phone number as the Account 
  * `Not Assigned` Prevent deletion of Accounts that have an active policy 
  * `Jonathan` Set Order Status to Deactivated if the Policy Status is set to Not Active 
  * MISSING
  
### Platform Events
  * Create a platform event
  * Apex code or flow that fires above platform event
  * An Apex Trigger or Platform-Event Triggered Flow that is invoked by the reception of the above Platform Event.

### Visualforce
  * A Visualforce page relevant to the business use case
    - [ ] Andy
    - [ ] Jonathan
    - [ ] Kevin
    - [ ] Rachel
    - [ ] Rama
  * Associated custom Apex code (either through a Custom Controller or Controller Extension)
    - [ ] Andy
    - [ ] Jonathan
    - [ ] Kevin
    - [ ] Rachel
    - [ ] Rama

## Peripheral Requirements

### Sales Cloud
  * `Rama` Lead assignment rules
  * `Not Assigned` Lead auto-response rules
  * `Not Assigned` Web-to-lead
  * `Not Assigned` Opportunity path with a celebratory effect upon completion

### Service Cloud
  * `Not Assigned` Case assignment rules
  * `Not Assigned` Case auto-response rules
  * `Not Assigned` Web-to-case
  * `Not Assigned` Case path

### Process Automation
  * Workflow rule
  * Process configured through Process Builder
  * `Jonathan` Multi-step approval process
  * `Kevin` Schedule-triggered flow
  * Platform-event-triggered flow

### Experience Cloud
  * `All` Create a customer-facing Experience Cloud site
  
### Lightning Web Components
  * `All` Create multiple Lightning web components surfaced either internally or on the customer-facing Experience site
