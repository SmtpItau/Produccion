USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALCULO_LINEAS_OPCIONES_OTRO]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RECALCULO_LINEAS_OPCIONES_OTRO]
	(   
		@cSistema			CHAR(3)  
	,	@nMostarMensajes	int = 1
	)
AS   
BEGIN  

	SET NOCOUNT ON  
  
	 CREATE TABLE #TMP_RESULTADO_Aux  
   (   Rut          NUMERIC(9)  
   ,   Codigo       INT  
   ,   NumContrato  NUMERIC(10)     
   ,   Operador     CHAR(15)
   ,   MetodologiaLCR	INT 
  
   )  

   CREATE TABLE #TMP_RESULTADO  
   (   Rut          NUMERIC(9)  
   ,   Codigo       INT  
   ,   NumContrato  NUMERIC(10)     
   ,   Operador     CHAR(15)  
   ,   MetodologiaLCR	INT  
   ,   Id           INT identity(1,1)  
   )  
  
   INSERT INTO #TMP_RESULTADO_aux  
   SELECT DISTINCT  
          CaRutCliente  
   ,      CaCodigo  
   ,      CaNumContrato  
   ,      CaOperador   
   ,	  'MetodologiaLCR' = ISNULL(dbo.FN_RIEFIN_METODO_LCR( clrut, clcodigo, clrut, clcodigo),1)--RQ_8800   
   FROM   CaEncContrato
   INNER JOIN lnkBac.BacParamSuda.dbo.CLIENTE ON clrut = CaRutCliente and clcodigo = CaCodigo
	where CaEstado <> 'C'  -- ERROR: No descarta las cotizaciones  
   ORDER BY CaRutCliente, CaCodigo      
  

   -- En este proceso Sólo se realizara recalculo de las metodologias
   -- Tradicionales
   INSERT INTO #TMP_RESULTADO  
   SELECT DISTINCT  
          Rut  
   ,      Codigo  
   ,      NumContrato  
   ,      Operador   
   ,	  MetodologiaLCR
   FROM   #TMP_RESULTADO_aux
   where MetodologiaLCR in ( 1, 4 )
   ORDER BY Rut, Codigo      

   
   DELETE lnkBac.BacLineas.dbo.MENSAJE_LINEAS  
   WHERE  Sistema = @cSistema  
  
   DECLARE @iReg   NUMERIC(9)  
       SET @iReg   = ( SELECT MAX( id ) FROM #TMP_RESULTADO )  
   DECLARE @Cont   NUMERIC(9)  
       SET @Cont   = ( SELECT MIN( id ) FROM #TMP_RESULTADO )  
   DECLARE @iRec   INT  
       SET @iRec   = 0     
  
   DECLARE @iRut          NUMERIC(9)  
   DECLARE @iCod          INT  
   DECLARE @iNumContrato  NUMERIC(10)    
   DECLARE @Operador      CHAR(15)  
   DECLARE @MsjOper       VARCHAR(255)  
   DECLARE @R             NUMERIC(9)  
   DECLARE @C             NUMERIC(9)  
   DECLARE @Oper          NUMERIC(10)    
   DECLARE @Msj           VARCHAR(255)  
   DECLARE @Glosa         VARCHAR(255)  
   DECLARE @RutCli        NUMERIC(9)  
   DECLARE @CodCli        INT  
   DECLARE @Sist          CHAR(03)  
  
  
   
   UPDATE lnkBac.BacLineas.dbo.LINEA_SISTEMA   
   SET   TotalOcupado    = 0  
   ,   TotalExceso    = 0  
   ,   TotalDisponible = TotalAsignado  
   WHERE  id_sistema      = @cSistema  
      AND TotalOcupado    <> 0   
 --     AND Rut_Cliente in (  select MoRutCliente from MoHisEncContrato )  
   
  
   UPDATE lnkBac.BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO  
   SET   TotalOcupado    = 0  
   ,   TotalExceso    = 0  
   ,   TotalDisponible = TotalAsignado  
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

		if @nMostarMensajes = 1
		begin
			SELECT 'NO',  ' PROCESO DE RECALCULO DE LINEAS NO HA FINALIZADO EN FORMA CORRECTA...' + ' EXISTEN PROBLEMAS CON ALGUNA(S) OPERACION(ES)...'   
		end

	END ELSE   
	BEGIN 
	
		if @nMostarMensajes = 1
		begin
			SELECT 'OK', 'PROCESO DE RECALCULO DE LINEAS FINALIZO EN FORMA EXITOSA...'  
		end

	END  
  
   DROP TABLE #TMP_RESULTADO     
   DROP TABLE #TMP_RESULTADO_Aux
END  
GO
