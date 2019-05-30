# Pinboard

NOTE: ResourceManager framework is uploaded separately in case the reviewer decides to not download the project, and review it here. Otherwise the framework is pod installed in PinboardDeveloperTest

# Hi, Let me guide you through my code

## Project Structure

- **PinboardDeveloperTest**: contains the implementation of the actual framework, which it ingests through pods. The mini implementation consists of a collection view that displays images and when tapped on the image, it takes to detail view of the image using TransitionDelegates. On reaching the end of the collection view, more images are lazy loaded (paginated collection view).
- **ResourceManager (Framework)**: This framework performs the actual task which was required. It allows the user to fetch/download data without the worrysome details of networking. All the user needs to do is create an endpoint and hand it to API, which would either fetch from server or cache.


## Code Structure & Design Patterns

As instructed, *SOLID* principles were implemented to the best of my knowledge, i) ensuring each class has a single responsibility ii) code is extendable iii) all child classes usefully extend parent classes iv) Every detailed method, depends on an abstraction.

Design Patterns followed were:
- **Facade**: All the complexity of Network and Caching code is hidden behind *ResourceManager* class, and the complexity of this class is hidden behind *Endpoint* extension. Any user who wants to interact with the framework only needs configure *ResourceManager* and after that, implement *Endpoint* protocol then call its methods.
- **Repository**: Following this pattern, a single point of entry is given to the networking classes. Creating a generic layout for any project, allowing them to make network calls without the fuss of it’s code.

**Protocol Oriented Programming**: I used this paradigm to ensure scalability, maintainability and testability of code.


## System Diagram

Follow the click for project’s [system diagram.](https://drive.google.com/file/d/1DB721vvzjfpjssi3HyT3qKh0CqddG3dd/view?usp=sharing)


## Testability

Since designing network and cache library was the task, I only unit tested the concrete classes in ResourceManager framework which are CacheManager and ResourceManager.

Overall code coverage of both these classes has been achieved to 88.8%.

## Framework Integration

ResourceManager has been configured to be added through cocoa pods. And pod installed in this project.

You can access the ResourceManager files under *Pods-> Development pods -> ResourceManager*
