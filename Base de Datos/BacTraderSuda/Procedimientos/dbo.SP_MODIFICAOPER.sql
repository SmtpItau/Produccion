USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MODIFICAOPER]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MODIFICAOPER]
    (
    @nnumdocu numeric (10,0) ,
    @nnumoper numeric (10,0) ,
    @ncorrela numeric (3,0) ,
    @ctipoper char (03) ,
    @nrutcli numeric (10,0) ,
    @nforpagi integer  ,
    @nforpagv integer  ,
    @ntaspact numeric (10,5) ,
    @dfecvtop datetime ,
    @nvalvenp numeric (19,4) ,
    @cnomclie char (40)    ,
    @ncodcli numeric (05,0) ,

--REQUERIMENTO LD1_035_ITAU---------------------------------------
  --  @Sucursal  VARCHAR(05) = '',
    @Ejecutivo INTEGER = 00 ,
    @Rentabilidad VARCHAR(1) ,
   -- @cTipCus INTEGER = 00 ,
  --  @ModInver CHAR(1) ,
    @cRetiro CHAR(1) ,
    @cLaminas CHAR(1),
    @nSubFPago  INTEGER,
    @nSubFPago2 INTEGER,
    @cComision  CHAR(01) 
--REQUERIMENTO LD1_035_ITAU---------------------------------------

    )
as
begin
set nocount on

--REQUERIMENTO LD1_035_ITAU---------------------------------------

 DECLARE @fecha_pago_real datetime,
	 @fecha_pago_mañana datetime

 DECLARE @cRenta 	CHAR(01)
 DECLARE @cfecpro	DATETIME
 DECLARE @ntircompo	FLOAT
 DECLARE @nfeccompo	DATETIME
 DECLARE @tipo_cartera_financiera CHAR(01)
 DECLARE @cinstser	CHAR(12)
 DECLARE @cSerie	CHAR(06)
 DECLARE @Sirve 	CHAR(02)
 DECLARE @nrutcart	NUMERIC(09)
 DECLARE @ntipcart	NUMERIC(05)
 DECLARE @cfecemi	DATETIME
 DECLARE @nrutemi	NUMERIC(09)
 DECLARE @nmonemi	NUMERIC(03),
	@ntasemi	FLOAT,
	@nbasemi	NUMERIC(03),
	@cfecven	DATETIME,
	@dFecpcup	DATETIME,
	@nnominal	NUMERIC(19,4),
  	@nvalcomp	NUMERIC(19,4),
	@nvalcomuv	NUMERIC(19,4),
	@nTir		NUMERIC(9,4),
	@ncodigo	NUMERIC(05),
	@cProg		CHAR(12),
	@fvptircv	NUMERIC(19,4),
	@tipo_inversion	CHAR(01),
	@fecha_pagomañana DATETIME,
	@cSenala	NUMERIC(09),
	@dFecucup	DATETIME,
	@nTipoTir	FLOAT,
	@nvptirv	NUMERIC(19,4),
	@nvalcompv	NUMERIC(19,4),
	@cmascara	CHAR(12),
	@nRutClicomp	NUMERIC(9),
	@cGenemis	CHAR(10),
	@nValContv	NUMERIC(19,4),
	@pago_hoy	CHAR(01),
	@nForPagiOld	INTEGER


--REQUERIMENTO LD1_035_ITAU---------------------------------------

 declare @ncodmon numeric (3,0) ,
  @nnominalp numeric (19,0) ,
  @nvalmon numeric (19,4)

--REQUERIMENTO LD1_035_ITAU---------------------------------------
	 SELECT @cfecpro = acfecproc from mdac
--REQUERIMENTO LD1_035_ITAU---------------------------------------

  update mdpa set papapimp = 0.0 ,
   paconimp = 0.0
  where panumoper=@nnumoper
  if @@error<>0
  begin
   select 'NO','PROCESO DE MODIFICACI«N MDPA HA FALLADO'
   set nocount off
   return
  end
SELECT  @dfecvtop = convert(datetime,@dfecvtop,101)

                if @ctipoper='IC'
                begin
                  
                   update GEN_CAPTACION set rut_cliente = @nrutcli,
                                            codigo_rut  = @ncodcli,
                                            forma_pago  = convert(char(4),@nforpagi)
                                      where numero_operacion = @nnumoper
                   if @@error<>0
                   begin
                 select 'NO','PROCESO DE MODIFICACI«N GEN_CAPTACION HA FALLADO'
   set nocount off
                 return
                   end
                end

  if @ctipoper='CP' or @ctipoper='VP'
  begin

--REQUERIMENTO LD1_035_ITAU---------------------------------------
   Select @nForPagiOld = moforpagi
   From Mdmo
   Where monumdocu=@nnumdocu and monumoper=@nnumoper and mocorrela=@ncorrela
--REQUERIMENTO LD1_035_ITAU---------------------------------------

   update MDMO
   set moforpagi = @nforpagi ,
    morutcli = @nrutcli,

--REQUERIMENTO LD1_035_ITAU---------------------------------------
       Ejecutivo = @Ejecutivo
     --  Tipo_Custodia = @cTipCus
--REQUERIMENTO LD1_035_ITAU---------------------------------------

   from mdac

   where monumdocu=@nnumdocu and monumoper=@nnumoper and mocorrela=@ncorrela
   if @@error<>0
   begin
    select 'NO','PROCESO DE MODIFICACI«N MDMO HA FALLADO'
    set nocount off
    return
   end
   
-- -------------------------------------------------------------------------------
-- +++ VFBF 11072018 modificacion de datos en tabla de pago mañaana     
-- -------------------------------------------------------------------------------
    update MDMOPM
    set morutcli = @nrutcli ,
     moforpagi = @nforpagi ,
     Ejecutivo = @Ejecutivo
    where monumdocu=@nnumdocu and monumoper=@nnumoper and mocorrela=@ncorrela
    if @@error<>0
    begin
     select 'NO','PROCESO DE MODIFICACION MDMOPM HA FALLADO'
     set nocount off
     return
    end
-- -------------------------------------------------------------------------------
-- --- VFBF 11072018 modificacion de datos en tabla de pago mañaana     
-- -------------------------------------------------------------------------------       
   if @ctipoper='CP'
   begin
    update MDCP
    set cprutcli = @nrutcli,
--REQUERIMENTO LD1_035_ITAU---------------------------------------
        Ejecutivo = @Ejecutivo,
        Tipo_Rentabilidad = @Rentabilidad
     --   Tipo_Custodia = @cTipCus
--REQUERIMENTO LD1_035_ITAU---------------------------------------

    where cpnumdocu=@nnumdocu and cpcorrela=@ncorrela
    if @@error<>0
    begin
     select 'NO','PROCESO DE MODIFICACI«N MDCP HA FALLADO'
     set nocount off 
     return
    end
   end
  end
  else
  begin
   if @ctipoper='VI' or @ctipoper='CI' or @ctipoper = 'IC'
   begin
    update MDMO
    set morutcli = @nrutcli ,
     moforpagi = @nforpagi ,
     moforpagv = @nforpagv ,
     motaspact = @ntaspact ,
     mofecvenp = @dfecvtop ,
     movalvenp = @nvalvenp,

--REQUERIMENTO LD1_035_ITAU---------------------------------------
     
	 Ejecutivo = @Ejecutivo,
    -- Tipo_Custodia = @cTipCus,
     sub_forma_ini  = @nSubFPago,
     sub_forma_venc = @nSubFPago2

--REQUERIMENTO LD1_035_ITAU---------------------------------------

      where monumdocu=@nnumdocu and monumoper=@nnumoper and mocorrela=@ncorrela
    if @@error<>0
    begin
     select 'NO','PROCESO DE MODIFICACI«N MDMO HA FALLADO'
     set nocount off
     return
    end
   end
   if @ctipoper='VI'
   begin
 
   update MDVI
    set virutcli = @nrutcli ,
     viforpagi = @nforpagi ,
     viforpagv = @nforpagv ,
     vitaspact = @ntaspact ,
     vifecvenp = @dfecvtop ,
     vivalvenp = @nvalvenp,

--REQUERIMENTO LD1_035_ITAU---------------------------------------

     Ejecutivo = @Ejecutivo
   --  Tipo_Custodia = @cTipCus

--REQUERIMENTO LD1_035_ITAU---------------------------------------

    where vinumdocu=@nnumdocu and vinumoper=@nnumoper and vicorrela=@ncorrela
    if @@error<>0
    begin
     select 'NO','PROCESO DE MODIFICACI«N MDVI HA FALLADO'
     set nocount off
     return
    end
   end
   if @ctipoper='CI'
   begin
    update MDCI
    set cirutcli = @nrutcli ,
     ciforpagi = @nforpagi ,
     ciforpagv = @nforpagv ,
     citaspact = @ntaspact ,
     cifecvenp = @dfecvtop ,
     civalvenp = @nvalvenp,

--REQUERIMENTO LD1_035_ITAU---------------------------------------
     Ejecutivo = @Ejecutivo
     --Tipo_Custodia = @cTipCus
--REQUERIMENTO LD1_035_ITAU---------------------------------------

    where cinumdocu=@nnumdocu and cicorrela=@ncorrela
    if @@error<>0
    begin
     select 'NO','PROCESO DE MODIFICACI«N MDCI HA FALLADO'
     set nocount off
     return
    end
    update MDDI
    set difecsal = @dfecvtop
    where dinumdocu=@nnumdocu and dicorrela=@ncorrela
    if @@error<>0
    begin
     select 'NO','PROCESO DE MODIFICACI«N MDDI HA FALLADO'
     set nocount off
     return
    end
   end
   -- Mofificacion ECP
   if @ctipoper='RC' or @ctipoper='RV'
   begin
    update MDMO
    set moforpagV = @nforpagV 
    where monumdocu=@nnumdocu and monumoper=@nnumoper and mocorrela=@ncorrela
    if @@error<>0
    begin
     select 'NO','PROCESO DE MODIFICACI«N MDMO HA FALLADO'
     set nocount off
     return
    end
   end
   if @ctipoper='IB'
   begin
    select @ncodmon = isnull(momonpact,0) from MDMO where monumoper=@nnumoper
    select @nnominalp = 0.0 ,
     @nvalmon = 0.0
    if @ncodmon<>999
  
    begin
     select @nvalmon = isnull(vmvalor,0.0) from VIEW_VALOR_MONEDA where @ncodmon=vmcodigo and @dfecvtop=vmfecha
     if @nvalmon=0
      select @nnominalp = 982.0 --* uf desconocida
     else
      select @nnominalp = 981.0 --* uf conocida
    end
     
    update MDMO
    set morutcli = @nrutcli ,
     moforpagi = @nforpagi ,
     moforpagv = @nforpagv ,
     motaspact = @ntaspact ,
     mofecvenp = @dfecvtop ,
     mofecven = @dfecvtop ,
     motir  = @ntaspact ,
     monominal = @nvalvenp ,
     monominalp = @nnominalp ,
     movalvenp = @nvalvenp,

--REQUERIMENTO LD1_035_ITAU---------------------------------------

     Ejecutivo = @Ejecutivo

--REQUERIMENTO LD1_035_ITAU---------------------------------------

    where monumdocu=@nnumdocu and monumoper=@nnumoper and mocorrela=@ncorrela
    if @@error<>0
    begin
     select 'NO','PROCESO DE MODIFICACI«N MDMO HA FALLADO'
     set nocount off
     return
    end
    update MDCI
    set cirutcli = @nrutcli ,
     ciforpagi = @nforpagi ,
     ciforpagv = @nforpagv ,
     citaspact = @ntaspact ,
     citircomp = @ntaspact ,
     cifecvenp = @dfecvtop ,
     cifecven = @dfecvtop ,
     cinominal = @nvalvenp ,
     cinominalp = @nnominalp ,
     civalvenp = @nvalvenp,

--REQUERIMENTO LD1_035_ITAU---------------------------------------
     Ejecutivo = @Ejecutivo,
     Tipo_Rentabilidad = @Rentabilidad
--REQUERIMENTO LD1_035_ITAU---------------------------------------

    where cinumdocu=@nnumdocu and cicorrela=@ncorrela
    if @@error<>0
    begin
     select 'NO','PROCESO DE MODIFICACI«N MDCI HA FALLADO'
     set nocount off
     return
    end
   end
  end
select 'OK'
set nocount off
end
GO
