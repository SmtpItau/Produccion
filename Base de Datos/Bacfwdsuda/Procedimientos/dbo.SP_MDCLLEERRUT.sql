USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCLLEERRUT]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MDCLLEERRUT]   
       (  
        @nrutcli     NUMERIC(9,0)=0   ,  -- Rut    Cliente  
        @ncodcli     NUMERIC(9,0)=0   ,  -- Codigo Cliente  
 @ntipcli     NUMERIC(5,0)=0      -- Tipo Cliente  
       )  
AS  
BEGIN  
  
SET NOCOUNT ON  


  
   SELECT * INTO #TMP_CLIENTE_EXT FROM BacparamSuda..CLIENTE   
  WHERE cltipcli = @ntipcli OR @ntipcli  = 0  
  
   SELECT       clrut                                ,     -- 1  
                cldv                                 ,     -- 2  
                clcodigo                             ,     -- 3  
                clnombre                             ,     -- 4  
                ISNULL(claglosa,'')                  ,     -- 5  
                cldirecc                             ,     -- 6  
                clcomuna                             ,     -- 7  
                clregion                             ,     -- 8  
                cltipcli                             ,     -- 9  
                CONVERT( CHAR(10), clfecingr, 103 )  ,     -- 10  
                clctacte                             ,     -- 11  
                clfono                               ,     -- 12  
                clfax                                ,     -- 13  
                0                                    ,     -- 14  
                clcalidadjuridica                    ,     -- 15  
                clciudad                             ,     -- 16  
                clentidad                            ,     -- 17  
                clmercado                            ,     -- 18  
                clgrupo                              ,     -- 19  
                clapoderado                          ,     -- 20  
                clpais                               ,     -- 21  
                clcodigo                             ,     -- 22  
                'clnumsinacofi' = ISNULL((SELECT clnumsinacofi FROM VIEW_SINACOFI WHERE clrut = @nrutcli  and clcodigo = @ncodcli),'0000'),     -- 23  
                'clnomsinacofi' = ISNULL((SELECT clnomsinacofi FROM VIEW_SINACOFI WHERE clrut = @nrutcli  and clcodigo = @ncodcli),''),          -- 24  
                'Remunera_Linea' = ISNULL((SELECT remuneracion_linea FROM VIEW_LINEA_GENERAL WHERE rut_cliente = @nrutcli  and codigo_cliente = @ncodcli),0)          ,-- 25  
  fecha_escritura                      ,--26  
         nombre_notaria         ,--27     
  clFechaFirma_cond        --28  
 , 'DES_CIUDAD' = ISNULL((SELECT nombre FROM BACPARAMSUDA..CIUDAD  
      WHERE codigo_ciudad =  ISNULL(CASE WHEN CLIENTE.Clcomuna = 3201 THEN 3201   
              ELSE CLIENTE.Clciudad END,'')),'')  
 , 'DES_COMUNA' = ISNULL((SELECT  nombre FROM BACPARAMSUDA..COMUNA   
      WHERE codigo_comuna = ISNULL(CLIENTE.Clcomuna,'')   
      AND codigo_ciudad = ISNULL(CASE WHEN CLIENTE.Clcomuna = 3201 THEN 3201   
              ELSE CLIENTE.Clciudad END,'')),'')  
 , NUEVO_CCG_FIRMADO  
 , 'FechaNuevoCcg' = CONVERT(CHAR(10),FECHA_FIRMA_NUEVO_CCG,103)  
 , clvigente  
    ,   'MetodologiaLCR' = ISNULL(BacLineas.dbo.FN_RIEFIN_METODO_LCR( @nrutcli, @ncodcli, @nrutcli, @ncodcli ),1)    -- PRD8800      
    ,   'Mto_Lin_Threshold' = ISNULL((SELECT Monto_Linea_Threshold FROM BacLineas..LINEA_GENERAL WHERE Rut_Cliente = @nrutcli  and Codigo_Cliente = @ncodcli),0)          -- PRD8800  

 --> PRD-19111
 , 'ComDer'	= ComDer --37
 
 /*FROM #TMP_CLIENTE_EXT   CLIENTE  
 , VIEW_ABREVIATURA_CLIENTE   
          WHERE ( clrut    = @nrutcli  AND ( clcodigo  = @ncodcli or @ncodcli = 0) )  
 AND  ( clrut   *= clarutcli AND   clcodigo *= clacodigo )*/  
  
 --RQ 7619  
 FROM #TMP_CLIENTE_EXT   CLIENTE LEFT OUTER JOIN VIEW_ABREVIATURA_CLIENTE   
           ON ( clrut = clarutcli AND   clcodigo = clacodigo )  
 WHERE ( clrut    = @nrutcli  AND ( clcodigo  = @ncodcli or @ncodcli = 0) )  
   
       
  
  SET NOCOUNT OFF  
  
END  


GO
