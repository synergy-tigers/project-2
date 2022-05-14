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
  * `Rama` Autolaunched Flow 

### Reports & Dashboards
  * `Andy` At least one standard and one custom report

## Core Programmatic Requirements
  
### Apex Testing
  * Ensure that Apex code has adequate test coverage and follow testing best practices both individually and as a team
    - [ ] Andy
    - [X] Jonathan
    - [X] Kevin
    - [ ] Rachel

### Apex Triggers
  * `Kevin` Accounts can't have more than one health insurance policy. Trying to add more than one health insurance product should trigger an error 
  * `Rachel` Relate a Contact to an Account if the contact has the same phone number as the Account 
  * `Rama` Prevent deletion of Accounts that have an active policy 
  * `Jonathan`
    - After insert trigger on Order to automatically add product to order
    - Before insert trigger to set standard price book
    - Before update trigger to check for approval status.
  * `Andy` Prevent creation of an account if an already-existing account has the same phone number.
  
### Platform Events
  * `All` Create a platform event
  * `All` Apex code or flow that fires above platform event
  * `All` An Apex Trigger or Platform-Event Triggered Flow that is invoked by the reception of the above Platform Event.

### Visualforce
  * A Visualforce page relevant to the business use case
    - [ ] `Andy` Account
    - [X] `Jonathan` Policies
    - [X] `Kevin` Opportunities
    - [X] `Rachel` Cases
  * Associated custom Apex code (either through a Custom Controller or Controller Extension)
    - [ ] Andy
    - [X] Jonathan
    - [X] Kevin
    - [X] Rachel

## Peripheral Requirements

### Sales Cloud
  * `Rama` Lead assignment rules
  * `Kevin` Lead auto-response rules
  * `Rachel` Web-to-lead
  * `Kevin` Opportunity path with a celebratory effect upon completion

### Service Cloud
  * `Kevin` Case assignment rules
  * `Kevin` Case auto-response rules
  * `Kevin` Web-to-case
  * `Kevin` Case path

### Process Automation
  * Workflow rule
  * `Jonathan` Process configured through Process Builder
  * `Jonathan` Multi-step approval process
  * `Kevin` Schedule-triggered flow
  * `All` Platform-event-triggered flow

### Experience Cloud
  * `Rachel` Create a customer-facing Experience Cloud site
  
### Lightning Web Components
  * `Rachel` Create multiple Lightning web components surfaced either internally or on the customer-facing Experience site
