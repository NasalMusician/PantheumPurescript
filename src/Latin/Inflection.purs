module Pantheum.Latin.Inflection where

import Prelude ((<<<))
import Data.Show (class Show, show)
import UIHelpers (class Display, display)
import Pantheum.Inflection.Table (class IsUnit)

data Degree = Positive | Comparative | Superlative
instance showDegree :: Show Degree where
    show Positive = "positive"
    show Comparative = "comparative"
    show Superlative = "superlative"
instance displayDegree :: Display Degree where
    display = display <<< show
instance degreeIsntUnit :: IsUnit Degree where
    isunit _ = false

data Person = FirstP | SecondP | ThirdP
instance showPerson :: Show Person where
    show FirstP = "1st person"
    show SecondP = "2nd person"
    show ThirdP = "3rd person"
instance displayPerson :: Display Person where
    display = display <<< show
instance personIsntUnit :: IsUnit Person where
    isunit _ = false

data Numerus = Singular | Plural
instance showNumerus :: Show Numerus where
    show Singular = "singular"
    show Plural = "plural"
instance displayNumerus :: Display Numerus where
    display = display <<< show
instance numerusIsntUnit :: IsUnit Numerus where
    isunit _ = false

data Tense = Present | Imperfect | Future | Perfect | Pluperfect | FuturePerfect
instance showTense :: Show Tense where
    show Present = "present"
    show Imperfect = "imperfect"
    show Future = "future"
    show Perfect = "perfect"
    show Pluperfect = "pluperfect"
    show FuturePerfect = "future-perfect"
instance displayTense :: Display Tense where
    display = display <<< show
instance tenseIsntUnit :: IsUnit Tense where
    isunit _ = false

data Voice = Active | Passive
instance showVoice :: Show Voice where
    show Active = "active"
    show Passive = "passive"
instance displayVoice :: Display Voice where
    display = display <<< show
instance voiceIsntUnit :: IsUnit Voice where
    isunit _ = false

data Mood = Indicative | Subjunctive
instance showMood :: Show Mood where
    show Indicative = "indicative"
    show Subjunctive = "subjunctive"
instance displayMood :: Display Mood where
    display = display <<< show
instance moodIsntUnit :: IsUnit Mood where
    isunit _ = false
