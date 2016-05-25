-- Elm code for the website
-- Copyright 2016, Sjors van Gelderen

module Main (..) where

import Html exposing (Html)
import Html.Events as Events
import Markdown

type alias Model =
  { count : Int }

type Action =
    Nothing
  | Increase Int
    
markdown : String
markdown = """

#Sjors van Gelderen

##Software extraordinaire

Hello, dear reader!
I am a computer programmer,
and this is my portfolio website.

I write C++!
```
#include <iostream>

int main()
{
  std::cout << "Hello C++" << std::endl;
  return EXIT_SUCCESS;
}
```

I write C#!
```
using System;

namespace Main
{
  public class Main
  {
    public int main()
    {
      Console.WriteLine("Hello C#!");
      return 0;
    }
  }
}
```

I write Rust!
```
fn main() {
  println!("Hello Rust!");
}
```

I write F#!
```
let main args =
  printfn "Hello F#!"
  0
```

I write Elm!
```
import Html exposing (text)

main =
  text "Hello Elm!"

-- Incidentally, this website was written using Elm!
-- Check out the source code on my GitHub!
```

"""
    
initialModel : Model
initialModel =
  { count = 0 }

view : Signal.Address Action -> Model -> Html
view address model =
  Html.div
    []
    [ Html.div [] [ Markdown.toHtml markdown ], --(toString model.count) ],
      Html.button
        [ Events.onClick address (Increase 100) ]
        [ Html.text "Test button" ] ]

update : Action -> Model -> Model
update action model =
  case action of
    Increase amount ->
      { model | count = model.count + amount }
        
    _ ->
      model

mb : Signal.Mailbox Action
mb =
  Signal.mailbox Nothing
               
modelSignal : Signal.Signal Model
modelSignal =
  Signal.foldp update initialModel mb.signal

main : Signal.Signal Html
main =
  Signal.map (view mb.address) modelSignal
