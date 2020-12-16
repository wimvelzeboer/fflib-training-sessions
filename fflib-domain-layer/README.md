# Domain Layer
Deep dive into the domain layer structure used in the Apex Enterprise Patterns

## Contents

- [Separation of Concern](#separation-of-concern)
    - [Domain](#domain)
    - [Selector](#selector)
    - [Service](#service)
- [Hands on session](#hands-on-session)
    - [The user story](#the-user-story)
    - [Write the feature test](#feature-test)
    - [Implement the high level business logic](#implement-the-high-level-business-logic)
        - [Creation of Service Layer](#create-service-layer-logic-for-accounts)
        - [Create Implementation of Service Layer](#create-implementation)
        - [Write high level business logic](#write-high-level-business-logic)
    - [Implement low level business logic](#implement-low-level-business-logic)
        - [Create Accounts domain implementation](#create-accounts-domain-implementation)
        - [Create Contacts domain implementation](#create-contacts-domain-implementation)
        - [Create Contacts selector implementation](#create-contacts-selector-implementation)
    - [Add business logic trigger points](#add-business-logic-trigger-points)
        - [Create Trigger](#create-trigger)
    - [Refactoring](#refactoring)
- [Resources](#resources)
    

## What is a Domain Layer?
The domain is a wrapper around a list of objects and contains methods to;

- *Getters* - Retrieve information for the objects inside the domain
- *Setters* - Change data on the objects in the domain
- *Selectors* - Select a subset of records based on criteria

The objects in the domain contain data in the form of Salesforce records (SObjects) or objects/classes containing data,
also known as Data Transfer Object (DTO). 

A domain should only contain data of one type.

## How to structure a Domain Layer class



**IMPORTANT**

The domain should not be aware of any other class or object besides itself.
Object inside the list contained by the domain can change, 
but the list will always contain the same objects.

**Example methods**
```apex
// returns a list with all the Account names of the objects in the domain
List<String> getAccountNames();

// changes the ShippingCountry on all objects in the domain to the provided value
void setShippingCountry(String countryName);          

// create a new instance of the same domain but only with those objects matching the provided value for ShippingCountry
Accounts selectByShippingCountry(String countryName); 

// returns a set of all the object Ids 
Set<Id> getRecordIds();