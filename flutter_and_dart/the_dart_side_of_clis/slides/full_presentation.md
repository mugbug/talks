---
marp: true
theme: uncover
class: invert
---

# The **Dart** Side of CLIs

---

## Who am I?

Pedro Zaroni,
Tech Lead @ **QuintoAndar**

---

# Agenda

- ***What*** is a CLI?
- ***When*** it makes sense to create a custom one?
- And ***how*** would we do it?

---

# What is a **CLI**?

A command line program that accepts text input to perform some processing and may return some output.

---

## What is a **CLI**?

## Examples

- flutter
- dart
- very_good_cli
- flutterfire

---

# ***When*** it would make sense to create a custom CLI?

---

## ***When ...***

... we need to **mix many commands** and/or scripts together in a relatively **complex** way

---

## ***When ...***

... we have one or more **script that is shared** between many projects and teams and we need to keep it always up to date for all of them

---

## ***When ...***

... we want to easily **add automated tests** to our scripts

---
## ***When ...***

... we want to provide a single and **easy-to-find hub of tooling** to all team members

---
## ***When ...***

... we want to create plug-and-play automations


---

## Real world examples

- linter for conventional commits
- any sort of guardrail logic for PRs (linters etc)
- release process automations
- abstraction to run e2e tests

---

# But **how** would we do it?

---

# 👩‍💻 It's **cooode** time!

---

# Wrap up

- very_good_cli as starting point
- args package
- mason_logger
- _Cmd and CLIs structure
- UX is important

---

# References & further reading

- [marp gist][1] (the tool used for these slides)
- [very_good_cli][2] (used for generating this template and also as a code reference on how to code and test a CLI)
- [Generate a Dart CLI with Very Good CLI][3]

---

# Repo with demo and slides


![width:400px height:400px](assets/repo_qr_code.png)

---

# $ shutdown -h now 👋🤖

[1]: https://gist.github.com/yhatt/a7d33a306a87ff634df7bb96aab058b5
[2]: https://github.com/VeryGoodOpenSource/very_good_cli
[3]: https://verygood.ventures/blog/generate-command-line-application-cli
