{-# LANGUAGE QuasiQuotes, TypeFamilies, GeneralizedNewtypeDeriving, TemplateHaskell,
             OverloadedStrings, GADTs, FlexibleContexts, FlexibleInstances, EmptyDataDecls #-}

module Week.Types where

import Prelude hiding ((++))
import Snap.Plus
import Database.Persist.Types
import Database.Persist.TH
import Snap.Snaplet.Persistent (showKey)
import Data.Aeson.Types

import qualified Course.Types as C

share [mkPersist sqlSettings] [persistLowerCase|
Week
  courseId C.CourseId
  number Int
  deriving Show
  deriving Eq
|]

type WeekEntity = Entity Week

instance ToJSON (Entity Week) where
  toJSON (Entity key (Week courseId number)) =
    object ["id" .= showKey key, "number" .= number]

weekPath :: WeekEntity -> Text
weekPath (Entity key _) = "/weeks/" ++ showKey key

weekDeletePath :: WeekEntity -> Text
weekDeletePath entity = weekPath entity ++ "/delete"