# Currency App

## Definition

This project displays the last information about rates of Bitcoins in the last two weeks. It also displays a detail screen with the information of bitcoin rate in USD, GBP and EUR

## How to run the project

Since we are not using any kind of external libraries for this project, just opening the project and run on a simulator in XCode. Easy as that! :D

## About the project

#### Infrastructure 


The `Infrastructure` is basically what the App is about and what use cases contains, divided on Entities, UseCases and dataSources.

#### Interface
It is the main of the `Application` is responsible for delivering information to the user and handling user input. It contains the Scenes which will implement our delivery Pattern or architecture design.

###### Scenes
It is the main presentation layer. It has been used a clean MVP architecture.


## Detail 

#### Infrastructure

Entities are implemented as Swift value types, implementing the Decodable protocol to parse directly from json decoder

Stores are data sources:

    - NetworkStore -> provides data from network
    - MockStore -> provides mock data
    
Data Transport

    - CurrencyDto is a data transport object to pass data through scenes in the way fit best for our usage

#### Network

The Network is custom layer implementing a protocol which will be the main interface for the network data stores. Right now we are not using any external library, but in case we decide to use it, we can change it easily with a Facade implementing our desired protocol.

#### Interface

 - Scenes
        Scenes are implemented using MVP architecture. To also use the clean code pattern, we have added Workers, Models and Routers.
        Having our Output and Input protocols declared within the Presenter layer, we can handle using our main business logic decoupled from our presentation layer. So, we can use any kind of presentation layer or framework, just implementing the methods declared by our OutputsProtocols.
        Our Workers decide where to retreive the data and what source will use for that.
        Our Router will navigate through the different scenes and will also provide the injected data to next scene.


#### Scene


### TODO:

* add tests 

### Links
* [MVP](https://apiumhub.com/es/tech-blog-barcelona/patron-mvp-ios/)
* [Clean Architecture - MVP](https://medium.com/lovecoding/simple-mvp-architecture-for-ios-app-20fbde0e6ebb)

