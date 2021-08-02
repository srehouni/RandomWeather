# RandomWeather

## Weather Loader Feature Specs

### Story: Display the weather of a random location

### Narrative #1

```
I want the app to display the weather of a random location
So I can have some fun checking the weather of other places
```

#### Scenarios (Acceptance criteria)

```
Given the customer has connectivity
When the customer opens the app to see a random locations weather
Then the app should display the weather for such random location
```

## Use Cases

### Load the weather Use case

#### Data:
- URL

#### Primary course (happy path):
1. Execute Load Weather with above data
2. System downloads data from url
3. System validates downloaded data
4. System creates weather info from valid data
5. System delivers weather info

#### Invalid data – error course (sad path):
1. System delivers invalid data error

#### No connectivity – error course (sad path):
1. System delivers connectivity error.

---

## Architecture
![Architecture](architecture.png)

The architecture is based on a modular design following the clean architecture and SOLID principles. The dependency between modules is from the outside in, which means inner modules don't depend on outter modules.
There are 6 modules:
1. Domain (Business logic)  
2. API (Application logic - Use case)
3. Presentation (Presentation logic)
4. UI 
5. API Infra
6. Application

There is also a seventh module which contains some compontes that can be used from other modules.

### Domain (Business logic)

