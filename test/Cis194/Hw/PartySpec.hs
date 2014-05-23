module Cis194.Hw.PartySpec (main, spec) where

import Test.Hspec
import Cis194.Hw.Party
import Cis194.Hw.Employee
import Data.Monoid

bob   = Emp { empFun = 10, empName = "Bobbo" }
sue   = Emp { empFun = 20, empName = "Suzie" }
joe   = Emp { empFun = 40, empName = "Joe" }
empty = GL [] 0

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "glCons" $ do
    it "should return a new GuestList with Employee added and new fun-score" $ do

      let notEmpty = GL [bob, sue] (empFun bob + empFun sue)

      glCons bob empty `shouldBe` GL [bob] 10
      glCons joe notEmpty `shouldBe` GL [joe, bob, sue] 70

  describe "GuestList" $ do
    it "behaves like a Monoid" $ do
      let joeList = GL [joe] 40
      let sueList = GL [sue] 20

      mappend empty joeList `shouldBe` joeList
      mappend joeList sueList `shouldBe` GL [joe, sue] 60
      mconcat [empty, joeList, sueList] `shouldBe` GL [joe, sue] 60

  describe "moreFun" $ do
    it "returns the GuestList with the highest fun score" $ do
      let joeList = GL [joe] 40
      let sueList = GL [sue] 20

      moreFun empty joeList `shouldBe` joeList
      moreFun joeList sueList `shouldBe` joeList

