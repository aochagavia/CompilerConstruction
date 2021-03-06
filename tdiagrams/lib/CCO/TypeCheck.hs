module CCO.TypeCheck (
    typeCheck,
    typeCheckATerm
) where

import CCO.Component (component, printer, Component)
import CCO.Tree (parser, ATerm, Tree (fromTree, toTree))
import CCO.TypeCheck.AG
import qualified CCO.TypeCheck.Util as T
import CCO.Feedback (errorMessage, Feedback)
import CCO.Printing (text)
import Control.Arrow (Arrow (arr), (>>>))

typeCheck' :: Diag -> Feedback Diag
typeCheck' d = case sem_Diag d of
                 T.Error e -> errorMessage $ text e
                 _         -> return d

typeCheck :: Component String String
typeCheck = parser >>> typeCheckATerm >>> printer

typeCheckATerm :: Component ATerm ATerm
typeCheckATerm = component toTree >>> component typeCheck' >>> arr fromTree
