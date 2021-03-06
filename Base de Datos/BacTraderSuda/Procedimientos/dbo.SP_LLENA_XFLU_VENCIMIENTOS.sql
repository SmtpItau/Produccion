USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_XFLU_VENCIMIENTOS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LLENA_XFLU_VENCIMIENTOS] (  @RUT    CHAR(10)                    --  2
                                                  ,@REF    nvarchar(20)                --  3
                                                  ,@COPE   CHAR (20)                   --  4
                                                  ,@CORR   numeric(2)                  --  5
                                                  ,@NCUA   numeric(5)                  --  6
                                                  ,@NTOC   CHAR(3)                     --  7
                                                  ,@SEPA   CHAR(1)                     --  8
                                                  ,@NSEP   numeric(19)                 --  9
                                                  ,@FVEN   datetime                    -- 10
                                                  ,@VAMO   numeric(19)                 -- 11
                                                  ,@INTE   numeric(19)                 -- 12
                                                  ,@COMI   numeric(1)                  -- 13
                                                  ,@VCUO   numeric(19,4)               -- 14   
                                                  ,@SVCA   numeric(19)                 -- 15
                                                  ,@TASA   numeric(19,4)               -- 16
                                                  ,@CRELL  CHAR(15)                    -- 17
                                                  ,@sw     numeric(1)
                                             )

AS
BEGIN 

IF @SW = 1    -- valida si existen datos 
   DELETE TABLA_INTERFAZ_VCTO WHERE DESCR = 1

SET @TASA =@TASA /1000

INSERT TABLA_INTERFAZ_VCTO VALUES('2', @RUT  , @REF  , @COPE , @CORR , @NCUA , @NTOC , @SEPA  , @NSEP 
                                      , @FVEN , @VAMO , @INTE , @COMI , @VCUO , @SVCA , @TASA  , @CRELL
                                      , 1  
                                  )
                                          

END 

GO
