USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDVMGRABARVALMON]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_MDVMGrabarValMon    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MDVMGrabarValMon    fecha de la secuencia de comandos: 14/02/2001 09:58:30 ******/
CREATE PROCEDURE [dbo].[SP_MDVMGRABARVALMON]
       (
        @ncodigo     NUMERIC(03,0)   ,
        @nvalor      NUMERIC(18,10)  ,
        @nvalorcmp   NUMERIC(18,10)  ,
        @nvalorvta   NUMERIC(18,10)  ,
        @cfecha      CHAR(10)
       ) 
AS   
BEGIN 
SET NOCOUNT ON
   /*=======================================================================*/
   DECLARE @dfecha      DATETIME
   /*=======================================================================*/
   SELECT @dfecha = CONVERT( DATETIME, @cfecha )
   /*=======================================================================*/
   IF EXISTS( SELECT       vmcodigo,
      vmvalor ,
      vmptacmp,
      vmptavta,
      vmfecha ,
   /*   vmliborsemanal,
      vmlibormes1   ,
      vmlibormes2   ,
      vmlibormes3   ,
      vmlibormes4   ,
      vmlibormes5   ,
      vmlibormes6   ,
      vmlibormes7   ,
      vmlibormes8   ,
      vmlibormes9   ,
      vmlibormes10  ,
      vmlibormes11  ,
      vmlibormes12  ,*/
       vmtipo,
      vmparidad,
      vmparmer,
      vmposini,
      vmprecoi,
      vmparini,
      vmprecoc,
      vmparidc,
      vmposic,
      vmpreco,
      vmpreve,
      vmpmeco,
      vmpmeve,
      vmtotco,
      vmtotve,
      vmutili,
      vmparco,
      vmparve,
      vmorden,
      vmctacmb,
      vmcmbini,
      vmreval,
      vmarbit,
      vmparmer1,
      vmnumstgo
                     FROM  VALOR_MONEDA 
                     WHERE vmcodigo = @ncodigo  AND
                           vmfecha  = @dfecha
            ) BEGIN
      /*====================================================================*/
      UPDATE       VALOR_MONEDA
             SET   vmvalor  = @nvalor                                       ,
                   vmptacmp = @nvalorcmp                                    ,
                   vmptavta = @nvalorvta
             WHERE vmcodigo = @ncodigo    AND
                   vmfecha  = @dfecha 
   /*=======================================================================*/
   END ELSE BEGIN
      /*====================================================================*/
      INSERT INTO VALOR_MONEDA  ( vmcodigo, vmvalor,   vmptacmp,   vmptavta, vmfecha )
                VALUES ( @ncodigo, @nvalor, @nvalorcmp, @nvalorvta, @dfecha )
   END
   /*=======================================================================*/
   SET NOCOUNT OFF
   SELECT 0
END

GO
