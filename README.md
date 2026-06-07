# Learning from the Expense Tracker Project

## 1. Keep Domain Models Independent from the UI Layer

Enums and domain models should remain independent of the presentation layer. They should not contain UI-specific information such as colors, icons, widgets, or styling details.

When data needs to be persisted, always consider how it will be stored and retrieved from a database. Since many databases do not support enums directly, each enum should provide a mechanism to:

* Convert enum constants into a primitive identifier suitable for storage.
* Reconstruct enum constants from stored primitive values.

A separate UI mapping layer can then translate domain values into their corresponding visual representations. This separation keeps the codebase cleaner, easier to maintain, and more scalable as the application grows.

---

## 2. Prefer Explicit State Updates Over `unfocus()` Side Effects

Using `unfocus()` as a trigger to persist form data can lead to unreliable behavior. Although `unfocus()` executes synchronously, widget rebuilds and frame updates may introduce timing-related issues.

A more predictable approach is to update editable objects directly through callbacks such as:

* `onChanged`
* `onSubmitted`
* Parent callback patterns

Keeping the underlying data model synchronized with user input in real time reduces dependency on widget lifecycle events and improves reliability.

---

## 3. Dispose Controllers and Remove Listeners Properly

Any resource that registers listeners or manages state should be cleaned up when the widget is removed from the widget tree.

Examples include:

* `TextEditingController`
* `ScrollController`
* `AnimationController`
* `FocusNode`
* Custom listeners

Whenever a listener is added using `addListener()`, the corresponding listener should be removed using `removeListener()`. Likewise, controllers should be disposed within the widget's `dispose()` method.

Proper cleanup prevents memory leaks, unintended callbacks, and resource retention.

---

## 4. Stateful Widgets Own Stateful Objects

Any widget that creates and manages objects whose state must survive rebuilds should be implemented as a `StatefulWidget`.

Common examples include:

* `TextEditingController`
* `GlobalKey`
* `ScrollController`
* `AnimationController`
* `FocusNode`
* Custom state objects

Creating these objects inside a `StatelessWidget` causes them to be recreated whenever the widget rebuilds, resulting in lost state such as:

* Text input values
* Scroll positions
* Focus information
* Animation progress

### Use a StatelessWidget When

A widget should remain stateless when:

1. It is purely presentational.
2. It only renders data received through constructor parameters.
3. Its behavior is entirely controlled by its parent.
4. It contains only immutable (`final`) fields.
5. It does not manage controllers, focus, animations, or local mutable state.

Choosing the appropriate widget type helps preserve state correctly and improves overall architecture.

---

## 5. Prefer Builder Functions for Bottom Sheet Content

When displaying a modal bottom sheet, avoid passing a prebuilt widget directly as the sheet content.

Instead, provide a `WidgetBuilder` (or equivalent builder callback) that constructs the content when the bottom sheet is shown.

```dart
showModalBottomSheet(
  context: context,
  builder: (context) => const MyBottomSheet(),
);
```

Bottom sheets are inserted into a separate part of the widget hierarchy. Building their content through a builder function ensures they receive the latest inherited widgets and configuration updates, including:

* Theme changes
* Localization updates
* MediaQuery updates
* Other inherited widget dependencies

Using builders results in more reactive and resilient UI behavior.

---

## Key Architectural Takeaway

A recurring theme throughout this project is the separation of responsibilities:

* Domain models should focus on business data.
* UI layers should handle presentation concerns.
* State should be updated explicitly rather than relying on side effects.
* Stateful resources should have clearly defined lifecycles.
* Widgets should be built in contexts where they can react to framework updates.

Following these principles leads to code that is easier to understand, maintain, test, and extend.
