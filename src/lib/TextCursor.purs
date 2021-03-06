module TextCursor
    ( TextCursor(..)
    , beforeL, selectedL, afterL -- my lens naming convention: *L
    , selectAll, moveCursorToStart, moveCursorToEnd
    , content, empty, single
    , insert, mapAll
    ) where

import Prelude
import Data.Newtype (class Newtype)
import Data.Lens (Lens', lens, (.~))
import Data.Lens.Iso.Newtype (_Newtype)

-- | The `TextCursor` type represents text selection within an input element.
-- | It consists of three regions of text: the text before the cursor, the text
-- | selected, and the text after the selection. This allows replacements to
-- | occur while keeping intact the cursor position/selection.
newtype TextCursor = TextCursor
    { before :: String
    , selected :: String
    , after :: String
    }

derive instance textCursorNewtype :: Newtype TextCursor _

-- | Get the current text in the field. (Everything before, inside, and after
-- | the selection.)
content :: TextCursor -> String
content (TextCursor { before, selected, after }) = before <> selected <> after

-- | An empty input field. No selection.
empty :: TextCursor
empty = TextCursor { before: "", selected: "", after: "" }

-- | Lens for the text before the selection. Empty if the cursor is at the
-- | beginning or the selection starts from the beginning.
beforeL :: Lens' TextCursor String
beforeL = _Newtype <<< lens (_.before) (\o b -> o { before = b })

-- | Lens for the text that is selected. Empty if nothing is selected.
selectedL :: Lens' TextCursor String
selectedL = _Newtype <<< lens (_.selected) (\o s -> o { selected = s })

-- | Lens for the text after the selection. Empty if the cursor or selection
-- | reaches the end.
afterL :: Lens' TextCursor String
afterL = _Newtype <<< lens (_.after) (\o a -> o { after = a })

-- | Apply a `Lens` setting a value to an empty `TextCursor`. When used with
-- | `beforeL`, `selectedL`, or `afterL` this will provide a `TextCursor` with
-- | only one non-empty field.
single :: Lens' TextCursor String -> String -> TextCursor
single l v = l .~ v $ empty

-- | Map all three fields of the `TextCursor` with an endomorphism, performing
-- | a replacement or other transformation such as normalization.
mapAll :: (String -> String) -> TextCursor -> TextCursor
mapAll f (TextCursor { before, selected, after }) = TextCursor
    { before: f before
    , selected: f selected
    , after: f after
    }

-- | Move the cursor to the start of a field, preserving the overall text
-- | content.
moveCursorToStart :: TextCursor -> TextCursor
moveCursorToStart tc = TextCursor
    { before: ""
    , selected: ""
    , after: content tc
    }

-- | Select all of the text in a field.
-- |
-- | Note: selection direction is not specified.
selectAll :: TextCursor -> TextCursor
selectAll tc = TextCursor
    { before: ""
    , selected: content tc
    , after: ""
    }

-- | Move the cursor to the end of a field, preserving the overall text content.
moveCursorToEnd :: TextCursor -> TextCursor
moveCursorToEnd tc = TextCursor
    { before: content tc
    , selected: ""
    , after: ""
    }

-- | Insert a string at the cursor position. If text is selected, the insertion
-- | will be part of the selection. Otherwise it is inserted before the cursor.
insert :: String -> TextCursor -> TextCursor
insert insertion = case _ of
    TextCursor { before, selected: "", after } -> TextCursor
        { before: before <> insertion
        , selected: ""
        , after: after
        }
    TextCursor { before, selected, after } -> TextCursor
        { before: before
        , selected: selected <> insertion
        , after: after
        }
