---
marp: true
theme: uncover
class: invert
---

# The **Dart** Side of CLIs

---

# Agenda

- ***What*** is a CLI?
- ***When*** it makes sense to create a custom one?
- And ***how*** would we do it?

---

# What is a **CLI**?

A tool that knows how to execute one or more commands and may accept extra arguments for customization.

---

###### What is a **CLI**?

## Examples

- flutter
- dart
- very_good
- flutterfire

---

# ***When*** it would make sense to create a custom CLI?

---

###### ***When ...***

... we need to **mix many commands** and/or scripts together in a relatively **complex** way

---

###### ***When ...***

... we have one or more **script that is shared** between many projects and teams and we need to keep it always up to date for all of them

---

###### ***When ...***

... we want to easily **add automated tests** to our scripts

---
###### ***When ...***

... we want to provide a single and **easy-to-find hub of tooling** to all team members

---

###### ***When ...***

... we want to **boost knowledge sharing** across teams

---

# But **how** would we do it?

---

# 👩‍💻 It's **cooode** time!

---

# References

- [command-line interface (CLI)][1]
- [marp gist][2] (the tool used for these slides)
- [very_good_cli][3] (used for generating this template and also as a code reference on how to code and test a CLI)

---

# shutting down... 👋🤖

[1]: https://www.techtarget.com/searchwindowsserver/definition/command-line-interface-CLI#:~:text=The%20MS%2DDOS%20operating%20system,can%20support%20command%2Dline%20interfaces.
[2]: https://gist.github.com/yhatt/a7d33a306a87ff634df7bb96aab058b5
[3]: https://github.com/VeryGoodOpenSource/very_good_cli
