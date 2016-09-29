# FOCS Homework for Day 9

You may edit your answers into this file, or add a separate file in the same directory.

If you add a separate file, please include the following at the top:

```
Student Name: Aidan McLaughlin
Check one:
[ ] I completed this assignment without assistance or external resources.
[X] I completed this assignment with assistance from ___
   and/or using these external resources: _Tutorials Point_ (to refresh on Pumping Lemma) and _http://www.jflap.org/tutorial/pda/construct/_ for info on PDAs in JFLAP
```

## 1. For each of the following languages, decide whether it is regular

For each of the following languages, decide whether it is regular.  If it is regular, give a regular expression or finite automaton that recognizes the language.  If it is not regular, demonstrate that using the pumping lemma.

a) Strings containing only the symbol a whose length is a power of 2 (*i.e.* length 2^n)
[The strings `a`, `aa`, `aaaa`, and `aaaaaaaa` are in this language; the string `aaaaa` is not.]

ANSWER: Irregular - with repetition of any selection of characters you can achieve a state that is outside of the accepted bounds


b) All strings with an equal number of occurrences of the substrings `01` and `10`.
[010 is in this language; `000110` is in the language; `0101010` is in the language; but `010101` is not.]

ANSWER: Regular - I've uploaded a JFLAP.


c) All strings (over {0,1}) consisting of a substring _w_ followed by the reverse of the substring.
[The strings `00100100` and `11110101011010101111` are in this language; the strings `00100` and `010101 `are not.]

ANSWER: Irregular - While it may work in some cases, there are many cases where repeating a selection 0 times would create a word outside of the language.


## 2. Play the pumping game

Play the **pumping game** (referenced on the [Day 8 page](https://sites.google.com/site/focs16fall/in-class-exercises/day-8) and also found at [http://weitz.de/pump/](http://weitz.de/pump/)).  Solve at least two puzzles from that page (that do NOT appear in question 1, above) and provide the word you chose, the substring the computer chose, and your successfully pumped string.

Notation notes:

- The notation |w| sub a means the number of `a`'s in the word _w_.
- _a_^_n_ means _n_ occurrences of `a` (e.g. _a_^8 is `aaaaaaaa`)

If you have other questions about notation (or anything else), please post them to [Piazza](https://piazza.com) so that we can clarify for everyone.

PUZZLE 4: Irregular
Language: { (a^n)(b^k)(a^n+k) | k, n in Natural Numbers }
My word: aaaaaaaaaabbbbbaaaaaaaaaaaaaaa [a10b5a15]
Computer's pick: aaaaaaaaaabbbb[baaaaaa]aaaaaaaaa
Pumped: aaaaaaaaaabbbbaaaaaaaaa (removed selection)

PUZZLE 15: Irregular
Language: { (a^n)(b^n^2) | n in Natural Numbers }
My word: aaaaabbbbbbbbbbbbbbbbbbbbbbbbb [a5b25]
Computer's pick: aaaaab[bb]bbbbbbbbbbbbbbbbbbbbbb
Pumped: aaaaabbbbbbbbbbbbbbbbbbbbbbb (removed selection)


## 3. Create a PDA

For one of the non-regular languages in problem 1 or 2 above, create a PDA (preferably in JFLAP) and include it with your completed homework.



## 4. Reading

Optionally read Sipser pp. 101–125.

Optionally read Stuart pp. 128–134.

## 5. Install gprolog

Please download and install [gprolog](http://www.gprolog.org) before coming to class:

**Ubuntu**:

	$ sudo apt-get install gprolog

**Mac**, with [Homebrew](http://brew.sh) installed:

	$ brew install gnu-prolog

**Mac** without Homebrew, and **Windows**:

- Follow the instructions at [http://www.gprolog.org/#download](http://www.gprolog.org/#download).
