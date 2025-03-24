# Design Patterns

This document contains detailed information about design patterns used in the
project, their implementation details, and when to apply them.

## 🧩 Patterns in Use

### Repository Pattern

- **Purpose**: Abstracts the data layer, providing a clean API for data access.
- **Implementation Details**:

  ```typescript
  interface IRepository<T> {
    getById(id: string): Promise<T>;
    getAll(): Promise<T[]>;
    create(entity: T): Promise<T>;
    update(id: string, entity: T): Promise<T>;
    delete(id: string): Promise<boolean>;
  }

  class UserRepository implements IRepository<User> {
    // Implementation details...
  }
  ```

- **When to Use**: When you need to centralize data access logic, especially
  when working with complex data access or multiple data sources.
- **Benefits**:
  - Decouples business logic from data access
  - Makes code more testable
  - Centralizes data access logic

### Factory Pattern

- **Purpose**: Centralizes object creation logic.
- **Implementation Details**:
  ```typescript
  class ComponentFactory {
    createComponent(type: string, config: any): BaseComponent {
      switch (type) {
        case 'button':
          return new ButtonComponent(config);
        case 'input':
          return new InputComponent(config);
        case 'modal':
          return new ModalComponent(config);
        default:
          throw new Error(`Unknown component type: ${type}`);
      }
    }
  }
  ```
- **When to Use**: When you have complex object creation logic or when you want
  to create different objects based on conditions.
- **Benefits**:
  - Centralizes creation logic
  - Enables runtime decision making for object types
  - Hides implementation details

### Observer Pattern

- **Purpose**: Implements a subscription model where objects can subscribe to
  events and be notified when those events occur.
- **Implementation Details**:

  ```typescript
  interface Observer {
    update(data: any): void;
  }

  class Subject {
    private observers: Observer[] = [];

    addObserver(observer: Observer): void {
      this.observers.push(observer);
    }

    removeObserver(observer: Observer): void {
      const index = this.observers.indexOf(observer);
      if (index !== -1) {
        this.observers.splice(index, 1);
      }
    }

    notify(data: any): void {
      this.observers.forEach((observer) => observer.update(data));
    }
  }
  ```

- **When to Use**: When changes to one object may require changing others, and
  you don't know how many objects need to change.
- **Benefits**:
  - Loose coupling between related objects
  - Support for broadcast communication
  - Dynamic relationships between objects

## 🧰 Anti-patterns to Avoid

### God Object

- **Description**: A class that knows too much or does too much, often having
  too many responsibilities.
- **Warning Signs**:
  - Class has many unrelated methods/properties
  - Class is hard to understand or modify
  - Changes in one part of the class affect other parts
- **How to Fix**:
  - Apply Single Responsibility Principle
  - Extract cohesive groups of methods into new classes
  - Use composition over inheritance

### Singleton Abuse

- **Description**: Overusing the Singleton pattern when global state isn't
  necessary.
- **Warning Signs**:
  - Many Singleton classes
  - Difficulty in unit testing
  - Unexpected side effects when modifying state
- **How to Fix**:
  - Use dependency injection
  - Pass objects explicitly rather than accessing globals
  - Consider if shared state is really needed

## 📚 Related Resources

- [Design Patterns: Elements of Reusable Object-Oriented Software](https://www.amazon.com/Design-Patterns-Elements-Reusable-Object-Oriented/dp/0201633612)
- [Refactoring: Improving the Design of Existing Code](https://www.amazon.com/Refactoring-Improving-Design-Existing-Code/dp/0201485672)

## 📝 Version History

| Version | Date       | Author    | Changes       |
| ------- | ---------- | --------- | ------------- |
| 0.1     | 2025-03-23 | BIG BRAIN | Initial draft |
