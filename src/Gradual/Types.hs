module Gradual.Types where


import qualified Language.Haskell.Liquid.UX.Config as C
import Language.Fixpoint.Types

import qualified Data.HashMap.Strict as M

import Control.Monad.IO.Class

data GConfig = GConfig {gtarget :: String, depth :: Int, pId :: Int, pNumber :: Int, keepLog :: Bool}

whenLog :: MonadIO m =>  GConfig -> IO () -> m () 
whenLog gcf act = if keepLog gcf then liftIO act else return ()

defConfig :: GConfig
defConfig = GConfig "" 0 0 0 False

setPId :: GConfig -> Int -> GConfig
setPId cfg i = cfg {pId = i}

makeGConfig :: C.Config -> GConfig
makeGConfig cfg = defConfig {depth = C.gdepth cfg, gtarget = head $ C.files cfg, keepLog = True }



type GSub a = M.HashMap KVar (a, Expr)
type GMap a = M.HashMap KVar (a, [Expr])
type GSpan  = M.HashMap KVar [(KVar, Maybe SrcSpan)] 

toGMap :: [(KVar, (a, [Expr]))] -> GMap a
toGMap = M.fromList 

fromGMap :: GMap a -> [(KVar, (a, [Expr]))]
fromGMap = M.toList


fromGSub :: GSub a -> [(KVar, (a, Expr))]
fromGSub = M.toList


removeInfo :: GMap a -> GMap ()
removeInfo = M.map (\(_,x) -> ((),x))