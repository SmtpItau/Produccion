USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INGRABAR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INGRABAR]
                             ( @incodigo1 NUMERIC (03,0) ,
    @inserie1 CHAR (12) ,
    @inglosa1 CHAR (40) ,
    @inrutemi1 NUMERIC (09,0) ,
    @inmonemi1 NUMERIC (03,0) ,
    @inbasemi1 NUMERIC (03,0) ,
    @inprog1 CHAR (08) , 
    @inrefnomi1 CHAR (01) ,
    @inMDSE1 CHAR (01) ,
    @inmdtd1 CHAR (01) ,
    @inMDPR1 CHAR (01) ,
    @intipfec1 NUMERIC (01,0) ,
    @intasest1 NUMERIC (03,0) ,
    @intipo1 CHAR (03) ,
    @inemision1 CHAR (03) ,
    @ineleg  CHAR (01) ,
    @incontab CHAR (01))
AS
BEGIN
      SET NOCOUNT ON
 IF EXISTS(SELECT inserie FROM VIEW_INSTRUMENTO WHERE inserie=@inserie1)
  UPDATE VIEW_INSTRUMENTO SET incodigo = @incodigo1 ,
    inserie  = @inserie1 , 
    inglosa  = @inglosa1 ,
    inrutemi = @inrutemi1 ,
    inmonemi = @inmonemi1 ,
    inbasemi = @inbasemi1 ,
    inprog  = @inprog1 ,
    inrefnomi = @inrefnomi1 ,
    inMDSE  = @inMDSE1 ,
    inmdtd  = @inmdtd1 ,
    inMDPR  = @inMDPR1 ,
    intipfec = @intipfec1 ,
    intasest = @intasest1 ,
    intipo  = @intipo1 ,
    inemision = @inemision1 ,
    ineleg  = @ineleg ,
    incontab = @incontab
  WHERE inserie = @inserie1
 ELSE
  INSERT INTO VIEW_INSTRUMENTO (
     incodigo ,
     inserie  ,
     inglosa  ,
     inrutemi ,
     inmonemi ,
     inbasemi ,
     inprog  ,
     inrefnomi ,
     inMDSE  ,
     inmdtd  ,
     inMDPR  ,
     intipfec ,
     intasest ,
     intipo  ,
     inemision ,
     ineleg  ,
     incontab
    )
  VALUES  (
     @incodigo1 ,
     @inserie1 ,
     @inglosa1 ,
     @inrutemi1 ,
     @inmonemi1 ,
     @inbasemi1 ,
     @inprog1 ,
     @inrefnomi1 ,
     @inMDSE1 ,
     @inmdtd1 ,
     @inMDPR1 ,
     @intipfec1 ,
     @intasest1 ,
     @intipo1 ,
     @inemision1 ,
     @ineleg  ,
     @incontab )
      SET NOCOUNT OFF
         select 'OK'
END


GO
