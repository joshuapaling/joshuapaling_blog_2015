---
title: Redux
---

<h1>Redux</h1>

principals:
1. Entire state of app (data and ui) is stored in single "state tree" object
2. State tree is read-only. Dispatch an action to create an entirely new state tree.
3. State mutations must be pure functions, based only on previous state and the action.

1st principal: Everything that changes in your application, including the data and the ui state is contained in a single javascript object, called the state, or the state tree.

2nd principal: The state tree is read-only. Any time you want to change the state, you have to dispatch an action.

An action is a plain object describing the change. Just like the state is the minimal representation of the data in your app, the action is the minimal representation of the change to that data. Each action must have a type property

Whether initiated by a user interaction or a network request, any data that gets into a redux app gets there by actions.

Components don't know how stuff happens. They just know they have to send out an action.

UI is most predictable when it's described as a pure function of application state.

State changes in your app need to be a pure function, that takes the previous state, and the action, and returns the next state.
Even in large apps, there's a single function that calculates the next state, based on prev state and action.

3rd principal: To describe state mutations you have to write a pure function that takes the previous state, and the action, and returns the next state. This function is called the reducer.

## Store

The store binds together the 3 principals of redux.
It holds the current app state object. It lets you dispatch actions. And when you create it you need to specify the reducer,
which tells it how state is updated with actions.

A store accepts a function (the reducer) as an argument.
A store has 3 methods: getState, dispatch (an action) and subscribe (lets you register a callback that'll fire everytime an action has been dispatched)

Episode 9: shows how to protect yourself with deepFreeze in your tests to ensure the state is in fact not changed.

Reducer composition: different reducers describe how different parts of the state tree are updated in response to actions. Reducers are normal javascript functions so they can call other reducers to delegate and abstract away handling of updates to some part of the state they manage. There is still a single reducer at the top of your app.
