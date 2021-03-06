USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALC_LINEAS_INV]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RECALC_LINEAS_INV]  
AS   
BEGIN  
  
 SET NOCOUNT ON  
 DECLARE @ncont   INTEGER    ,  
  @Posicion1    CHAR(3)    ,  
  @Numoper   NUMERIC(10)   ,  
  @nCorrela  NUMERIC(09)   ,  
  @rut        NUMERIC(9)   ,  
  @CodCli       NUMERIC(9)   ,  
  @MtoMda1      NUMERIC(21,04)  ,  
  @fecvcto      CHAR(8)    ,  
  @fechini      CHAR(8)    ,  
  @MercadoLc    CHAR(1)    ,  
  @moneda    NUMERIC(5)   ,  
  @nregs    INTEGER  ,  
  @FecVen  DATETIME        ,  
  @rut1                 NUMERIC(9)   ,  
  @CodCli1              NUMERIC(9)   
  
  --+++CONTROL IDD, no debe calcular líneas BAC
  
--	RETURN
	
  -----CONTROL IDD, no debe calcular líneas BAC
  
  
    
  
 SELECT  * 
 INTO  #tmp_car   
 FROM   Text_Ctr_Inv  
 ,    text_arc_ctl_dri  
 WHERE cpfecven > acfecproc 
 AND    cpnominal > 0 
  
  
 /* Se debe actualizar el valor presente ya que los papeles que tengan ventas pueden tener fecha settlement posterior a la fecha
   de la venta y se debe actualizar solo el valor que esta disponible en cartera VGS 17/02/2005 */
 Update #tmp_car  
 Set CpVpTirc = cpvptirc * ISNULL((1 - (cpnomi_vta / cpnominal)),1)
  
 SELECT  @fechini = CONVERT(CHAR(8), acfecproc ,112)      
 FROM text_arc_ctl_dri  
  
  
--------- Rebaja lineas ----------------  
UPDATE  BACLINEAS..LINEA_SISTEMA   
SET TotalOcupado = 0  
, TotalExceso = 0  
, TotalDisponible = TotalAsignado  
WHERE  ID_SISTEMA = 'BEX'  
  
UPDATE  BACLINEAS..LINEA_PRODUCTO_POR_PLAZO  
SET TotalOcupado = 0  
, TotalExceso = 0  
, TotalDisponible = TotalAsignado  
WHERE  ID_SISTEMA = 'BEX'  
----------------------------------------  
delete BACLINEAS..linea_chequear  
where FechaOperacion = @fechini  
and  id_sistema = 'BEX'  
  
  
 SELECT @nregs = COUNT(*)
 FROM #tmp_car  
 SELECT @ncont = 1  
 WHILE @ncont <= @nregs
  BEGIN    
   SET ROWCOUNT @ncont  
   SELECT   
    @Posicion1 = 'CPX'      ,  
    @Numoper    = cpnumdocu     ,  
    @nCorrela   = cpcorrelativo ,  
    @rut      = CpRutEmi ,  
    @CodCli     = cpcodemi      ,  
    @rut1      = CpRutEmi ,  
    @CodCli1    = cpcodemi      ,  
    @MtoMda1    = CpVpTirc   ,  
    @fecvcto   = CONVERT(CHAR(8),CpFecVen ,112)    ,  
    @MercadoLc = CASE clpais WHEN 6 THEN 'S' ELSE 'N' END   ,  
    @Moneda    = CpMonEmi ,  
    @FecVen       = Cpfecven  
   FROM  #tmp_car ,  
    view_cliente  
   WHERE   CpRutEmi = clrut AND  
    cpcodemi = clcodigo  
  
--     IF EXISTS( SELECT 1 FROM baclineas..CLIENTE_RELACIONADO WHERE clrut_hijo = @rut1 AND clcodigo_hijo = @CodCli1 )
--		BEGIN
--			SELECT	@rut1 = clrut_padre		,
--				@CodCli1 = clcodigo_padre
--			FROM	baclineas..CLIENTE_RELACIONADO 
--			WHERE 	clrut_hijo 	= @rut1	AND
--				clcodigo_hijo 	= @CodCli1
--
--		END	
        
   SET ROWCOUNT 0  
   SELECT @ncont = @ncont + 1  

-- PRD-7666
--   IF EXISTS( SELECT * FROM baclineas..linea_sistema WHERE @rut1 = rut_cliente AND @codcli1 = codigo_cliente AND id_sistema = 'BEX' )
--      BEGIN

   IF EXISTS( SELECT * FROM baclineas..linea_sistema WHERE @rut = rut_cliente AND @codcli = codigo_cliente AND id_sistema = 'BEX' )
      -- or 1 = 1
      BEGIN  
  
    -- Esto para Imputar el Monto Ocupado a la Fecha, en el campo fecha inicio queda la fecha de proceso  
    EXECUTE baclineas..sp_Lineas_ChequearGrabar @fechini ,  
              'BEX'  ,   
              @Posicion1 ,   
              @Numoper  ,  
              @Numoper  ,  
              @nCorrela ,  
              @rut   ,  
             @CodCli  ,  
      @MtoMda1  ,  
      0  ,  
      @fecvcto  ,  
              ''  ,  
              @rut  ,  
              0  ,  
              @FecVen,  
              0  ,  
              'N'  ,  
              @moneda  ,  
              'C'  ,  
              0  ,  
              'N'  ,  
              0  ,  
              @fechini ,  
              0 ,  
       0 ,  
       0 ,  
       0 ,  
       ''  
  
    EXECUTE baclineas..sp_Lineas_GrbOperacion   'BEX'  ,  
              @Posicion1 ,  
              @Numoper ,  
              @Numoper ,  
              ' '  ,  
              'N'  ,  
              @MercadoLc  
  
  
  
  
     END  
  END  
  
UPDATE bacbonosextsuda..TEXT_MVT_DRI  
SET mostatreg = ''   
WHERE mostatreg = 'P'  
  
EXECUTE BACLINEAS..SP_RECALCULA_GENERAL  
  
  
 SET NOCOUNT OFF  
END  
GO
