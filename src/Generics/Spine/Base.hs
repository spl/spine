{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE GADTs #-}

module Generics.Spine.Base where

data Type :: * -> * where
  Char  :: Type Char
  Int   :: Type Int
  Bool  :: Type Bool
  List  :: Type a -> Type [a]
  Pair  :: Type a -> Type b -> Type (a, b)

data Typed a = (:>) { typeOf :: Type a, val :: a }

infixl 1 :>

data Constr a = Constr { constr :: a, name :: String }

data Spine :: * -> * where
  Con     :: Constr a -> Spine a
  (:<>:)  :: Spine (a -> b) -> Typed a -> Spine b

infixl 0 :<>:

type Datatype a = [Signature a]

data Signature :: * -> * where
  Sig    :: Constr a -> Signature a
  (:&:)  :: Signature (a -> b) -> Type a -> Signature b

infixl 0 :&:

