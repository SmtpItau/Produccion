USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_Grabar_Operaciones1446]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_Grabar_Operaciones1446] (
         @Entidad     NUMERIC(3)  ,
                                           @CODMON      CHAR(3)     ,
         @CODCNV     CHAR(3)     ,
         @FECHA  DATETIME    ,
         @HORA        CHAR(8)     ,
                @TERM       CHAR(12)    ,
         @OPER       CHAR(10)    ,
         @TIPMER      CHAR(4)     ,
         @MONMO       NUMERIC(9,2),
         @TIPOPE      CHAR(1)     ,
         @TICAM       NUMERIC(9,2),
         @NOMCLI      CHAR(35)    ,
         @RUTCLI      NUMERIC(11) ,
          @CODCL       NUMERIC(11)
                   )
                           
AS
 
Begin
 SET NOCOUNT ON
   DECLARE @xNumOper  numeric(9)
    SELECT @xNumOper = acnumoper 
                      FROM VIEW_MDAC
END
-- sp_Grabar_Operaciones1446 '1','USD','USD','20010101','24:25:01','3','ADMINSTRA','1446','1000','U','650','WILSON','11551818','8'
IF EXISTS (SELECT monumope FROM memo WHERE monumope =( @xNumOper + 1 ))
--IF EXISTS (select monumope from memo,VIEW_MDAC where VIEW_MDAC.acnumoper = memo.monumope )
   BEGIN
     SELECT "Error : Operacion existe"
     RETURN
   END
 else
  Begin
    INSERT INTO MEMO 
   (MOENTIDAD , 
    MOCODMON  ,
                  MOCODCNV  , 
                  MOFECH    ,
                  MOHORA    , 
                  MOTERM    ,
                  MOOPER    ,
                  MOTIPMER  ,
                  MOMONMO   , 
                  MOTIPOPE  ,
                  MOTICAM   ,
                  MONOMCLI  ,
                  MORUTCLI  ,
                  MOCODCLI  ,
                  MONUMOPE)
 
      
  values 
 (@Entidad ,
  @CODMON  ,
         @CODCNV  ,
         CONVERT(CHAR(8),@fecha ,112),
         CONVERT(CHAR(08),@HORA,108),  -- HORA 
         @TERM    ,
         @OPER    ,
         @TIPMER  ,
  @MONMO   ,
         @TIPOPE  , 
         @TICAM   ,
         @NOMCLI  ,
         @RUTCLI  ,
         @CODCL   ,
         @xNumOper + 1 )
   
   
 End
BEGIN
UPDATE VIEW_MDAC 
        SET acnumoper  = (acnumoper + 1 )
END
GO
