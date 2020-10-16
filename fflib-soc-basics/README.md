# AEP Training 1
Basics about Separation of Concern and the Apex Enterprise Patterns

## Contents

- [Separation of Concern](#separation-of-concern)
    - [Domain](#domain)
    - [Selector](#selector)
    - [Service](#service)
- [Hands on session](#hands-on-session)
    - [The user story](#the-user-story)
    - [Feature test](#feature-test)

## Separation of Concern

### Domain
![Domain](images/domain.png)
The domain is a wrapper around a list of objects and contains methods to;

- *Getters* - Retrieve information for the objects inside the domain
- *Setters* - Change data on the objects in the domain
- *Selectors* - Select a subset of records based on criteria

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
```

### Selector
![Selector](images/selector.png)
The purpose of the selector is to retrieve data from a source and return it.
The source can be a;
 
- Database; __c, __mdt, etc
- Platform cache
- Runtime memory
  
**IMPORTANT**

selector methods always accept arguments in bulk. The arguments are typically primitive variables in lists or sets.  
  
**Example methods**
```apex
// returns a list of Account objects where the shipping country is in the provided list
List<Account> selectByShippingCountry(Set<String> countryNames);
``` 

### Service
![Service](images/service.png)
The service layer contain the high level business logic. 
It is a shared point of execution for the logic. 


**IMPORTANT**

Use method overloading to enable different parts of the source to call the same logic,
even when they do not have the same set of information available, e.g.; Records VS RecordIds

**Example methods**
```apex
void doSomething(Set<Id> idSet);
void doSomething(List<Account> records);
void doSomething(Accounts accounts);
void doSomething(fflib_ISObjectUnitOfWork unitOfWork, Accounts accounts);
```  

## Hands on Session
This training will take you step by step through a simple user story. 
It shows you how to develop that using the Separation of Concerns principle 
with the Apex Enterprise Patterns.

The described user story is very simple, 
in fact it is so simple that you can resolve it without writing code.
But for the sake of this training we will use code. 

### The User story 

    GIVEN an account with contact records
    WHEN the ShippingCountry is changing on the account record
    THEN the country should be copied to all the MailingCountry field on all the child contacts of that account

### Feature test 
In this training we will develop our code using the Test Driven Development principles. 
The benefit of this is that you always know where you need to continue if you left off for a cup of coffee
or suddenly end up in a long discussion with a colleague.
You just run the test and voilà.
It will guarantee you that you have a very high code coverage
and will have it very easy when you ever have to do some refactoring. 

Let's create our feature test class file `AccountFeatureTest`.

<img src="images/new-file-accountfeaturetest.png" align="left" height="251" width="329" >

```apex
@IsTest
private class AccountFeatureTest
{
    @IsTest
    static void testBehavior()
    {
//      GIVEN an account with contact records
//      WHEN the ShippingCountry is changing on the account record
//      THEN the country should be copied to all the MailingCountry field on all the child contacts of that account
    }
}
```

