USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [bacuser].[pap_invex]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [bacuser].[pap_invex]
(           
                @tipoper CHAR(3)  
 , @monumoper FLOAT  
 , @CatLibro CHAR(10) = 1552
 , @CatCartNorm CHAR(10) = '1111'  
 , @CatCartFin CHAR(10) = '204'  
)  
        
AS  
BEGIN  
  
Declare @firma1 CHAR(15)  
Declare @firma2  CHAR(15)  
   
    Select @firma1=res.Firma1,  
   @firma2=res.Firma2  
    From BacLineas..detalle_aprobaciones res  
    Where res.Numero_Operacion=@monumoper  
  
    Select @firma1=IsNull(@Firma1,''),  
    @firma2=IsNull(@Firma2,'')  
  
 SET NOCOUNT ON  
  
  
 CREATE TABLE #tmp_papeleta (   
   tem_mofecpro   DATETIME NOT NULL DEFAULT ' ' ,--1  
   tem_morutcart   NUMERIC(9) NOT NULL DEFAULT 0 ,--2  
   tem_nombre_cart   CHAR (70) NOT NULL DEFAULT ' ' ,--3  
   tem_monumdocu   NUMERIC(12) NOT NULL DEFAULT 0 ,--4  
   tem_monumoper   NUMERIC(12) NOT NULL DEFAULT 0 ,--5  
   tem_Correlativo   NUMERIC(12) NOT NULL DEFAULT 1 ,--5   
   tem_motipoper   CHAR(3)  NOT NULL DEFAULT ' ' ,--6  
   tem_cod_familia   NUMERIC(4) NOT NULL DEFAULT 0 ,--7  
   tem_nom_familia   CHAR (20) NOT NULL DEFAULT ' ' ,--8  
   tem_id_instrum   CHAR (30) NOT NULL DEFAULT ' ' ,--9  
   tem_morutcli   NUMERIC(9) NOT NULL DEFAULT 0 ,--10  
   tem_nom_cli   CHAR (100) NOT NULL DEFAULT ' ' ,--11  
   tem_mofecemi   DATETIME NOT NULL DEFAULT ' ' ,--12  
   tem_mofecven   DATETIME NOT NULL DEFAULT ' ' ,--13  
   tem_momonemi   NUMERIC(3, 0) NOT NULL DEFAULT 0 ,--14  
   tem_glosa_monemi  CHAR(35) NOT NULL DEFAULT 0 ,  
   tem_motasemi   NUMERIC(19, 7) NOT NULL DEFAULT 0 ,--15  
   tem_mobasemi   NUMERIC(3, 0) NOT NULL DEFAULT 0 ,--16  
   tem_morutemi   NUMERIC(9) NOT NULL DEFAULT 0 ,--17  
   tem_nom_emi   CHAR(100) NOT NULL DEFAULT ' ' ,--18  
   tem_mofecpago   DATETIME NOT NULL DEFAULT ' ' ,--19  
   tem_monominal   NUMERIC(19, 4) NOT NULL DEFAULT 0 ,--20  
   tem_movalcomu   FLOAT   NOT NULL DEFAULT 0 ,  
   tem_movpresen   NUMERIC(19, 4) NOT NULL DEFAULT 0 ,--21  
   tem_movalvenc   NUMERIC(19, 4) NOT NULL DEFAULT 0 ,--22  
   tem_motir   NUMERIC(19, 7) NOT NULL DEFAULT 0 ,--23  
   tem_mopvp   NUMERIC(19, 7) NOT NULL DEFAULT 0 ,--24  
   tem_movpar   NUMERIC(19, 8) NOT NULL DEFAULT 0 ,--25  
   tem_moint_compra  NUMERIC(19, 4) NOT NULL DEFAULT 0 ,--26  
   tem_moprincipal   NUMERIC(19, 4) NOT NULL DEFAULT 0 ,--27  
   tem_movalven   NUMERIC(19, 4) NOT NULL DEFAULT 0 ,--28  
   tem_basilea   NUMERIC(1) NOT NULL DEFAULT ' ' ,--29  
   tem_glosa_basilea  CHAR(30) NOT NULL DEFAULT ' ' ,--30  
   tem_tipo_tasa   NUMERIC(3) NOT NULL DEFAULT ' ' ,--31  
   tem_glosa_tipo_tasa  CHAR(25) NOT NULL DEFAULT ' ' ,--32  
   tem_encaje   CHAR(1)  NOT NULL DEFAULT ' ' ,--33  
   tem_enca_sn   CHAR(2)  NOT NULL DEFAULT ' ' ,--34  
   tem_monto_encaje  NUMERIC(19, 4) NOT NULL DEFAULT 0 ,--35  
   tem_codigo_carterasuper  CHAR (1) NOT NULL DEFAULT ' ' ,--36  
   tem_glosa_carterasuper  CHAR(50) NOT NULL DEFAULT ' ' ,--37  
   tem_Tipo_Cartera_Financiera CHAR (2) NOT NULL DEFAULT ' ' ,--38  
   tem_sucursal   SMALLINT  NOT NULL DEFAULT ' ' ,--39  
   tem_nom_sucu   CHAR(70) NOT NULL DEFAULT ' ' ,--40  
   tem_corr_bco_nombre  CHAR(50) NOT NULL DEFAULT ' ' ,--41  
   tem_corr_bco_cta  CHAR(30) NOT NULL DEFAULT ' ' ,--42  
   tem_corr_bco_aba  CHAR(09) NOT NULL DEFAULT ' ' ,--43  
   tem_corr_bco_pais  CHAR(15) NOT NULL DEFAULT ' ' ,--44  
   tem_corr_bco_ciud  CHAR(15) NOT NULL DEFAULT ' ' ,--45  
   tem_corr_bco_swift  CHAR(30) NOT NULL DEFAULT ' ' ,--46  
   tem_corr_bco_ref  CHAR(30) NOT NULL DEFAULT ' ' ,--47  
   tem_corr_cli_nombre  CHAR(50) NOT NULL DEFAULT ' ' ,--48  
   tem_corr_cli_cta  CHAR(30) NOT NULL DEFAULT ' ' ,--49  
   tem_corr_cli_aba  CHAR(09) NOT NULL DEFAULT ' ' ,--50  
   tem_corr_cli_pais  CHAR(15) NOT NULL DEFAULT ' ' ,--51  
   tem_corr_cli_ciud  CHAR(15) NOT NULL DEFAULT ' ' ,--52  
   tem_corr_cli_swift  CHAR(30) NOT NULL DEFAULT ' ' ,--53  
   tem_corr_cli_ref  CHAR(30) NOT NULL DEFAULT ' ' ,--54  
   tem_operador_contraparte CHAR(30) NOT NULL DEFAULT ' ' ,--55  
   tem_operador_banco  CHAR(60) NOT NULL DEFAULT ' ' ,--55  
   tem_tipo_operacion  NUMERIC(02) NOT NULL DEFAULT ' ' ,--56  
   tem_nom_operacion  CHAR(20) NOT NULL DEFAULT ' ' ,--57  
   tem_para_quien   CHAR(15) NOT NULL DEFAULT ' ' ,--58  
   tem_glosa_para_quien  CHAR(15) NOT NULL DEFAULT ' ' ,  
   tem_glosa_car_financiera CHAR(50) NOT NULL DEFAULT ' ' ,--59  
   tem_calce   CHAR(1)  NOT NULL DEFAULT ' ' ,--60  
   tem_calce_glosa   char(10) NOT NULL DEFAULT ' ' ,--61  
   tem_nombre_custodia  char(50) NOT NULL DEFAULT ' ' ,--62  
   TEM_FECHA_IMP   DATETIME NOT NULL DEFAULT ' ' ,  
   TITULO    char(100) NOT NULL DEFAULT ' ' ,  
   TEM_MONTOEMI   numeric(19,4) NOT NULL DEFAULT 0 ,  
   TEM_MOMONPAG   CHAR(40) NOT NULL DEFAULT ' ' ,  
   tem_mostatreg   char(1)  NOT NULL DEFAULT ' ' ,  
   autori1    char(80) NOT NULL DEFAULT ' ' ,  
   autori2    char(80) NOT NULL DEFAULT ' ' ,  
   autori3    char(80) NOT NULL DEFAULT ' ' ,  
   TEM_moobserv   CHAR(80) NOT NULL DEFAULT ' ' ,  
   base_tasa   char(15) not null default ' ' ,  
   tem_forma_pago   char(80) not null default ' ' ,  
   tem_confirmacion  char(80) not null default ' ' ,  
   MONTO          NUMERIC(19,4) NOT NULL DEFAULT 0 ,  
   TiTulo2    char(80) NOT NULL DEFAULT ' ' ,--63  
   FECHA_NEG   DATETIME  NOT NULL DEFAULT ' ' ,  
   hora    CHAR(12) NOT NULL DEFAULT ' ' ,  
   calsificador1   char(30) NOT NULL DEFAULT ' ' ,  
   calsificador2   char(30) NOT NULL DEFAULT ' ' ,  
   clasif1    char(30) NOT NULL DEFAULT ' ' ,  
   clasif2    char(30) NOT NULL DEFAULT ' ' ,  
                 NombreEntidad                   char(50) NOT NULL DEFAULT ' ' ,  
   DireccEntidad                   char(50) NOT NULL DEFAULT ' ' ,  
   aprobacion   char(15) NOT NULL DEFAULT ' ' ,  
   observacion   char(1000) NOT NULL DEFAULT ' ' ,  
   utilidad         NUMERIC(19,4) NOT NULL DEFAULT 0 ,  
   perdida          NUMERIC(19,4) NOT NULL DEFAULT 0 ,  
   nemomoneda   char(10) NOT NULL DEFAULT ' ' ,  
   firma1    char(15) NOT NULL DEFAULT ' ' ,      
   firma2    char(15) NOT NULL DEFAULT ' ' ,  
   Glosa_Libro   CHAR(50) NULL  DEFAULT ' ' )  
  
  
 DECLARE @rut_cli   numeric (9) ,  
  @rut_emi  numeric (9) ,  
  @rut_car  numeric (9) ,  
  @cod_familia  numeric (4) ,  
  @cod_basilea   NUMERIC (1) ,  
  @cod_tipo_tasa   numeric (3) ,  
  @cod_encaje   char (1) ,  
  @cod_sucu   smallint ,  
  @cod_tipo_inver  numeric (2) ,  
  @codigo_carterasuper  char (5) ,  
  @codigo_car_financiera  char (2) ,  
  @calce   char (1) ,  
  @nombre_custodia char (30) ,  
  @para_quien  char (1) ,  
  @nominal  numeric(19,4) ,  
  @base_tasa  char(20) ,  
  @glosa_base_tasa char(15) ,  
  @cod_emi  numeric(1) ,  
  @cod_cli  numeric(9) ,  
  @MONTO   NUMERIC(19,4)   ,  
                @FECHA                   DATETIME  
  
    
 DECLARE @maxerrores   INTEGER  ,  
  @GlosaErrores   CHAR(1000) ,  
  @GlosaErr  CHAR(1000)  
    
  
 select  @rut_cli   = morutcli  ,  
  @rut_emi   = morutemi  ,  
  @rut_car  = morutcart  ,  
  @cod_familia  = cod_familia  ,  
  @cod_basilea   = basilea  ,  
  @cod_tipo_tasa   = tipo_tasa  ,  
  @cod_encaje   = encaje  ,  
  @cod_tipo_inver  = convert(numeric(1),tipo_inversion) ,  
  @cod_sucu   = sucursal  ,  
  @codigo_carterasuper  = codigo_carterasuper ,  
  @calce   = calce   ,  
  @para_quien  = para_quien  ,  
  @base_tasa  = base_tasa  ,  
  @cod_cli  = mocodcli  ,  
  @cod_emi  = cod_emi  ,  
  @MONTO   = momtum  
 from  text_mvt_dri  
 WHERE  monumoper = @monumoper  
  
        SELECT @FECHA = MAX(mofecpro)  
 FROM  text_mvt_dri  
 WHERE  monumoper = @monumoper  
  
-- Insert into #tmp_papeleta  
  SELECT mofecpro     , --1  
   morutcart   , --2  
   ' '    , --3  
   monumdocu    ,   --4  
   monumoper  ,  --5  
   mocorrelativo  ,  
   motipoper    , --6  
   cod_familia  , --7  
   ' '   , --8  
   id_instrum  , --9  
   morutcli     , --10  
   ' '   , --11  
   mofecemi     , --12  
   mofecven     , --13  
   momonemi  , --14  
   (SELECT MNGLOSA FROM VIEW_moneda WHERE momonemi = MNCODMON),  
   motasemi  , --15  
   mobasemi  , --16  
   morutemi  , --17  
   (select  nom_emi from text_emi_itl where rut_emi = morutemi and codigo = cod_emi) , --18  
   mofecpago  , --19  
   monominal   , --20  
   (CASE WHEN @TIPOPER = 'CP' THEN movalcomu ELSE movalven END ),   
   movpresen    , --21  
   movalvenc    , --22  
   motir       , --23  
   mopvp        , --24  
   movpar   , --25  
   moint_compra  , --26  
   moprincipal   , --27  
   movalven  , --28  
   basilea   , --29  
   ' '   , --30  
   tipo_tasa  , --31  
   ' '   , --32  
   encaje    , --33  
   ' '   , --34  
   monto_encaje  , --35  
   codigo_carterasuper , --36  
   (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartNorm AND TBCODIGO1 = codigo_carterasuper), --37  
   Tipo_Cartera_Financiera , --38  
   sucursal   , --39  
   ' '   , --40  
   corr_bco_nombre    , --41  
   corr_bco_cta       , --42  
   corr_bco_aba  , --43  
   corr_bco_pais  , --44  
   corr_bco_ciud  , --45  
   corr_bco_swift  , --46  
   corr_bco_ref    , --47  
   corr_cli_nombre  , --48  
   corr_cli_cta     , --49  
   corr_cli_aba  , --50  
   corr_cli_pais  , --51  
   corr_cli_ciud  , --52  
   corr_cli_swift  , --53  
   corr_cli_ref    , --54  
   operador_contraparte , --55  
   operador_Banco  ,  
   convert(numeric(2),tipo_inversion)   , --56  
   ' '   , --57  
   para_quien  , --58  
   ' '   , --  
   (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartFin AND TBCODIGO1 = Tipo_Cartera_Financiera) , --59  
   calce   , --60   
   ' '   , --61  
   Nombre_custodia  , --62  
   B.ACFECPROC  , --63  
   (CASE WHEN @TIPOPER = 'CP' THEN 'INVERSIONES EN EL EXTERIOR - COMPRA Nº ' + convert(char(10),monumoper)  
         WHEN @TIPOPER = 'VP' THEN 'INVERSIONES EN EL EXTERIOR - VENTA  Nº ' + convert(char(10),monumoper)  
         WHEN @TIPOPER = 'VP' AND mostatreg = 'P' THEN 'INVERSIONES EN EL EXTERIOR - VENTA PARCIAL Nº ' + convert(char(10),monumoper) END),  
   momontoemi,  
   (SELECT MNGLOSA FROM VIEW_moneda WHERE momonPAG = MNCODMON),  
   mostatreg,  
   ' ',  
   ' ',  
   ' ',  
   moobserv,  
   @base_tasa ,  
   isnull((select glosa from VIEW_forma_de_pago where codigo = forma_pago),' '),  
   isnull((select tbglosa from VIEW_TABLA_GENERAL_DETALLE where tbcateg = 1107 and tbcodigo1 = confirmacion),' '),  
   0,  
   (CASE WHEN mostatreg = 'A' THEN 'ANULACIÓN' else ' ' end),  
   MOFECNEG,  
   (convert(char(8),mohoraop,108)) ,  
   (select CLASIFICACION1  from text_emi_itl where morutemi = rut_emi and cod_emi = codigo ),  
   (select CLASIFICACION2 from text_emi_itl where morutemi = rut_emi and cod_emi = codigo ),  
   case  when cod_familia  = 2000 then (select tipo_largo1 from text_emi_itl where morutemi = rut_emi and cod_emi = codigo )  else (select tipo_corto1 from text_emi_itl where morutemi = rut_emi and cod_emi = codigo ) end ,  
   case  when cod_familia  = 2000 then (select tipo_largo2 from text_emi_itl where morutemi = rut_emi and cod_emi = codigo )  else (select tipo_corto2 from text_emi_itl where morutemi = rut_emi and cod_emi = codigo ) end ,  
                          ISNULL( (Select rcnombre from view_entidad),' ' ),  
   ISNULL( (Select rcdirecc from view_entidad),' '),  
   ISNULL(CASE  WHEN mostatreg = 'A' THEN 'ANULACION'  
     WHEN mostatreg = 'P' THEN 'PENDIENTE'  
     WHEN mostatreg = 'R' THEN 'RECHAZADO' ELSE '' END,''),  
   '',  
   moutilidad,  
   moperdida,  
   (SELECT MNNEMO FROM VIEW_moneda WHERE momonemi = MNCODMON)  
   ,@firma1,  
   @firma2  
  , (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatLibro AND TBCODIGO1 = Id_Libro)  
     
   FROM text_mvt_dri  
  , text_arc_ctl_dri B  
  WHERE  monumoper = @monumoper  
                AND     MOFECPRO  = @FECHA   
  
 declare @nom_cli    char (70) ,  
  @nom_cod   char  (15) ,  
  @nom_emi          char (60) ,  
  @nom_car   char (70) ,  
  @nom_basilea   char (20) ,  
  @nom_tip_tasa   char (35) ,  
  @nom_encaje   char (20)  ,  
  @nom_sucu   char (70) ,  
  @nom_inversion   char (30) ,  
  @glosa_carterasuper   char  (30) ,  
  @calce_glosa   char (10) ,  
  @glosa_para_quien  char (35) ,  
  @max                 INTEGER  ,  
  @x                   INTEGER  
  
  
 select @nom_cli = clnombre    
 from   VIEW_CLIENTE  
 where clrut = @rut_cli  
 and  clcodigo =  @cod_cli  
  
 select @nom_car = clnombre    
 from   VIEW_CLIENTE  
 where clrut = @rut_car  
   
/* select @glosa_carterasuper = TBGLOSA  
 from VIEW_TABLA_GENERAL_DETALLE  
 where TBCODIGO1 = @codigo_carterasuper  
 and tbcateg = 1111    
*/  
 select  @nom_cod = nom_familia  
 from text_fml_inm   
 where  cod_familia = @cod_familia  
  
 select  @nom_basilea = tbglosa   
 from  VIEW_TABLA_GENERAL_DETALLE   
 where  tbcateg = 1101 and tbcodigo1 = @cod_basilea   
  
 select  @glosa_para_quien = ISNULL(tbglosa, ' ')    
 from  VIEW_TABLA_GENERAL_DETALLE   
 where  tbcateg = 1105  
 AND tbcodigo1 = @para_quien  
  
 select  @nom_tip_tasa = tbglosa  
 from  VIEW_TABLA_GENERAL_DETALLE   
 where  tbcateg = 1102 and tbcodigo1 = @cod_tipo_tasa  
  
  
 if @cod_encaje = 'S'   
  select @nom_encaje = 'SI'  
 else begin  
  select @nom_encaje = 'NO'  
 end   
  
 if @calce= 'S'   
  select @calce_glosa = 'SI'  
  
 else begin  
  select @calce_glosa = 'NO'  
 end   
  
 select @nom_sucu  = ISNULL (ofi_nom, ' ' )  
 from ttab_ofi   
 where ofi_cod = @cod_sucu  
  
 Select @nom_inversion = tbglosa  
 From  VIEW_TABLA_GENERAL_DETALLE   
 Where tbcateg = 1104 and tbcodigo1 = @cod_tipo_inver  
  
 SELECT @nom_inversion = ISNULL(@nom_inversion,'')  
  
 update  #tmp_papeleta  set  
  autori1 = autoriza1 ,  
  autori2 = autoriza2 ,  
  autori3 = autoriza3  
 from  text_ctl_fir_ope  
 where tem_monominal > Menor  
 and tem_monominal < Mayor  
 or mayor = 0  
  
 SELECT @x = 1  
  
 SELECT @maxerrores = count(*) FROM VIEW_LINEA_TRANSACCION_DETALLE WHERE NumeroOperacion = @monumoper and Id_Sistema = 'BEX'  
  
 Select @GlosaErrores = ''  
  
 WHILE @x <= @maxerrores  
  BEGIN    
     
   SELECT  @GlosaErr  = Mensaje_Error  
    FROM  VIEW_LINEA_TRANSACCION_DETALLE  
   WHERE  NumeroOperacion  = @monumoper   
   and    Error   = 'S'  
   and  NumeroCorre_Detalle  = @x  
   and Id_Sistema   = 'BEX'  
  
   Select @GlosaErrores = RTRIM(@GlosaErrores) + ' - ' + RTRIM(@GlosaErr)  
  
          SELECT @x = @x + 1  
  END  
  
  
 UPDATE  #tmp_papeleta   
 SET tem_nom_cli   = @nom_cli,  
  tem_nom_familia  = @nom_cod,  
  tem_glosa_basilea  = @nom_basilea,        
  tem_glosa_tipo_tasa  = isnull(@nom_tip_tasa,' ') ,    
                tem_enca_sn  = @nom_encaje,  
  tem_nom_sucu   = ISNULL (@nom_sucu , ' '),    
                tem_nom_operacion  = @nom_inversion,  
  tem_nombre_cart  = @nom_car,  
--  tem_glosa_carterasuper =  ISNULL(@glosa_carterasuper,' ' ) ,  
  tem_calce_glosa  = @calce_glosa,  
  tem_glosa_para_quien  = @glosa_para_quien ,  
  MONTO    = @MONTO,  
  observacion  = ISNULL(@GlosaErrores,'')  
 WHERE  tem_monumoper = @monumoper  
  
  
 select *, 'RazonSocial'      = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)   
 from #tmp_papeleta   
 where tem_monumoper = @monumoper   
  
 SET NOCOUNT OFF  
END  


GO
