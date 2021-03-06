USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALCULO_LINEAS_OPCIONES]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RECALCULO_LINEAS_OPCIONES]

   (   @cSistema   CHAR(3)
   )
AS 
BEGIN

   SET NOCOUNT ON
   RETURN

   CREATE TABLE #TMP_RESULTADO
   (   Rut          NUMERIC(9)
   ,   Codigo       INTEGER
   ,   NumContrato  NUMERIC(10)   
   ,   Operador     CHAR(15)
   ,   Id           INTEGER identity(1,1)
   )

   INSERT INTO #TMP_RESULTADO
   SELECT DISTINCT
          CaRutCliente
   ,      CaCodigo
   ,      CaNumContrato
   ,      CaOperador 
   FROM   CaEncContrato 
   ORDER BY CaRutCliente, CaCodigo    

   DELETE lnkBac.BacLineas.dbo.MENSAJE_LINEAS
   WHERE  Sistema = @cSistema

   DECLARE @iReg   NUMERIC(9)
       SET @iReg   = ( SELECT MAX( id ) FROM #TMP_RESULTADO )
   DECLARE @Cont   NUMERIC(9)
       SET @Cont   = ( SELECT MIN( id ) FROM #TMP_RESULTADO )
   DECLARE @iRec   INTEGER
       SET @iRec   = 0   

   DECLARE @iRut          NUMERIC(9)
   DECLARE @iCod          INTEGER
   DECLARE @iNumContrato  NUMERIC(10)  
   DECLARE @Operador      CHAR(15)
   DECLARE @MsjOper       VARCHAR(255)
   DECLARE @R             NUMERIC(9)
   DECLARE @C             NUMERIC(9)
   DECLARE @Oper          NUMERIC(10)  
   DECLARE @Msj           VARCHAR(255)
   DECLARE @Glosa         VARCHAR(255)
   DECLARE @RutCli        NUMERIC(9)
   DECLARE @CodCli        INTEGER
   DECLARE @Sist          CHAR(03)


 
   UPDATE lnkBac.BacLineas.dbo.LINEA_SISTEMA 
   SET	  TotalOcupado 	  = 0
   ,	  TotalExceso 	  = 0
   ,	  TotalDisponible = TotalAsignado
   WHERE  id_sistema      = @cSistema
      AND TotalOcupado    <> 0 
 --     AND Rut_Cliente in (  select MoRutCliente from MoHisEncContrato )
 

   UPDATE lnkBac.BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO
   SET	  TotalOcupado 	  = 0
   ,	  TotalExceso 	  = 0
   ,	  TotalDisponible = TotalAsignado
   WHERE  id_sistema      = @cSistema
      AND TotalOcupado    <> 0  
--      AND Rut_CLiente in ( select MoRutCliente from MoHisEncContrato )
   
   WHILE @iReg >= @Cont
   BEGIN

      SELECT @iRut         = Rut
      ,      @iCod         = Codigo        
      ,      @iRec         = CASE WHEN @iReg = @Cont THEN 1 ELSE 0 END
      ,      @iNumContrato = NumContrato
      ,      @Operador     = Operador
      FROM   #TMP_RESULTADO
      WHERE  Id    = @Cont


      EXECUTE dbo.SP_LINEAS_OPCIONES @cSistema, @iRut, @iCod, @iRec, '', @iNumContrato
      SET @Cont = @Cont + 1

   END

    SELECT  *
           ,'Puntero' = Identity(INT)   
    INTO  #MENSAJES_LINEAS
    FROM  lnkBac.BacLineas.dbo.MENSAJE_LINEAS
    WHERE Mensaje = 'NO'


   IF EXISTS(SELECT  1  FROM  #MENSAJES_LINEAS ) 
   BEGIN 

    SET @R       = (SELECT MAX(Puntero) FROM #MENSAJES_LINEAS)
    SET @C       = (SELECT MIN(Puntero) FROM #MENSAJES_LINEAS)
    SET @MsjOper = ' '



           WHILE @R >= @C
           BEGIN       

                SELECT @Sist = Sistema  
                     , @Oper = NumOper
                     , @RutCli = RutCli      
                     , @CodCli = CodCli 
                     , @Msj    = Mensaje 
                     , @Glosa  = Glosa
                FROM   #MENSAJES_LINEAS
                WHERE Puntero   = @C

                SELECT 'Sistema' = @Sist 
                     , 'NumOper' = @Oper  
                     , 'RutCli'  = @RutCli 
                     , 'CodCli'  = @CodCli 
                     , 'Mensaje' = @Msj
                     , 'Glosa'   = @Glosa 


		SET @C   = @C + 1
                  
           END 


           SELECT 'NO',  ' PROCESO DE RECALCULO DE LINEAS NO HA FINALIZADO EN FORMA CORRECTA...' + ' EXISTEN PROBLEMAS CON ALGUNA(S) OPERACION(ES)...' 
   END 
   ELSE 
   BEGIN 
           SELECT 'OK', 'PROCESO DE RECALCULO DE LINEAS FINALIZO EN FORMA EXITOSA...'
   END

   DROP TABLE #TMP_RESULTADO   

END



GO
