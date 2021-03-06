USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ReHace_mdrs]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_ReHace_mdrs]
       (      @acfecproc   datetime
       ,      @acfecprox   datetime
       ,      @crscartera  varchar(5)
       ,      @crstipoper  varchar(5)
       )
as
begin 

       set nocount on

       /*
             DROP TABLE DBO.MDRS_REPROCESO

             SELECT *
             INTO   DBO.MDRS_REPROCESO_TEST
             FROM   MDRS
             WHERE  rsfecha >= '2016-04-01'
       */

       if not exists ( select 1 from sys.sysobjects where type = 'U' and name = 'tmp_chkinstser_regulariza' )
       begin
             create table dbo.tmp_chkinstser_regulariza
                    ( Error int, Mascara varchar(12), Codigo int, Serie varchar(12), RutEmis numeric(9), Monemi int, TasEmi float
                    , BasEmi numeric(3), FecEmi datetime, FecVen datetime, RefNomi char(1), Genemi char(10), NemMon    char(5)
                    , Corte      numeric(19,4), Seriado char(1), lesemi char(6), FecPro char(10)
                    )
       end

       select rsfecha
             ,      rsnumdocu,   rscorrela, rsnumoper
             ,      rscartera,   rstipoper
             ,      rsinstser,   rscodigo
             ,      rstir,       rsnominal,          rsvppresen, rsvppresenx
             ,      rsinteres,  rsinteres_acum,  rsintermes, rsinterescp,  rsinteres_acumcp
             ,      rsreajuste, rsreajuste_acum, rsreajumes, rsreajustecp, rsreajuste_acumcp
             ,   rsfeccomp
             ,      rsvalcomp
             ,      rsvalcomu
             ,      Registro            = row_number () over (order by rsnumdocu, rscorrela)
             ,      xValorPresente      = convert(float, 0.0)
             ,      xValorPresenteX     = convert(float, 0.0)
             ,      xInteres            = convert(float, 0.0)
             ,      xRsValComp          = convert(float, 0.0)
             ,      xRsValComu          = convert(float, 0.0)
             ,      rsfecemis
             ,      xReajuste           = convert(float, 0.0)
             ,      xTir                = convert(float, 0.0)
       into   #tmp_mdrs
--     from   BacTraderSuda.dbo.mdrs r with(nolock)
       from   BacTraderSuda.dbo.MDRS_REPROCESO_TEST
       where  rsfecha             = @acfecprox
       and    (      rscartera    = @crscartera or @crscartera = '' )
       and    (      rstipoper    = @crstipoper or @crstipoper = '' )
       and    not
             (      rsinstser    = 'BCAPS-F'    )
       
--     and          rsnumdocu    IN( 84301,  96186, 97759, 98489 ) 
--     and          rsinstser    = 'BUDC-A'
       
       declare @nFila                    numeric(9);         set @nFila                 = (select min(Registro) from #tmp_mdrs )
       declare @nFilas                   numeric(9);         set @nFilas                = (select max(Registro) from #tmp_mdrs )
       declare @rsnumdocu         numeric(9);         set @rsnumdocu             = 0 
       declare @rscorrela         numeric(9);         set @rscorrela             = 0
       declare @rsnumoper         numeric(9);         set @rsnumoper             = 0
       declare @rscartera         char(5);            set @rscartera             = ''
       declare @rstipoper         varchar(5);         set @rstipoper             = '' 

       declare @nModo                    int;                set @nModo                 = 2
       declare      @cFeccal            char(10);           set @cFeccal        = convert(char(10),@acfecproc, 112)
       declare @nCodigo           int;                set @nCodigo        = 0
       declare @cMascara          char(12);           set @cMascara       = ''
       declare @nMonemi           int;                set @nMonemi        = 0
       declare @cFecemi           char(10);           set @cFecemi        = ''
       declare @cFecven           char(10);           set @cFecven        = '' 
       declare @fTasemi           float;              set @fTasemi        = 0.0 
       declare @fBasemi           float;              set @fBasemi        = 0.0 
       declare @fTasest           float;              set @fTasest        = 0.0 
       declare @fNominal          float;              set @fNominal       = 0.0
       declare @fTir              float;              set @fTir                  = 0.0
       declare @fPvp              float;              set @fPvp                  = 0.0
       declare @fMT               float;              set @fMT                   = 0.0
       declare @fMTum                    float;              set @fMTum                 = 0.0
       declare @frsvppresen       float;              set @frsvppresen    = 0.0 
       declare @frsvppresenx      float;              set @frsvppresenx   = 0.0
       declare @frsvalcomp        float;              set @frsvalcomp            = 0.0
       declare @frsvalcomu        float;              set @frsvalcomu            = 0.0
       declare @fTasMer           float;              set @fTasMer        = 0.0
       declare @nTasaMercado      float;              set @nTasaMercado   = 0.0 
       declare @nValMercado       float;              set @nValmercado    = 0.0
       declare @nDifMercado       float;              set @nDifMercado    = 0.0 

       declare @fValcomu          float 
       declare @rsInteres         float;
       declare @rsReajuste        float;
       declare @rsInteres_acum    float;
       declare @rsReajuste_acum float;
       declare @rsInteres_Mes     float;
       declare @rsReajuste_Mes    float;

       declare @fValmon_Hoy       float;
       declare @fValmon_Man       float;
       declare @dFecComp          datetime
       declare @fIpc_cp           float;

       while ( @nFila <= @nFilas)
       begin

             select @cMascara           = rsinstser
                    ,      @fNominal           = rsnominal
                    ,      @fTir               = rstir
                    ,      @fPvp               = 0.0
                    ,      @fMT                = rsvppresenx
                    ,      @rsnumdocu          = rsnumdocu 
                    ,      @rscorrela          = rscorrela
                    ,      @rsnumoper          = rsnumoper
                    ,      @rscartera          = rscartera
                    ,      @rstipoper          = rstipoper
                    ,      @dFecComp           = rsfeccomp
                    ,      @frsvalcomp         = rsvalcomp
                    ,      @frsvalcomu         = rsvalcomu
                    ,      @rsInteres          = 0.0
                    ,      @rsReajuste         = rsreajuste
                    ,      @rsInteres_acum     = 0.0
                    ,      @rsReajuste_acum = 0.0
                    ,      @rsInteres_Mes      = 0.0
                    ,      @rsReajuste_Mes     = 0.0
                    ,      @cFecemi            = convert(char(10),rsfecemis, 112)
             from   #tmp_mdrs
             where  Registro            = @nFila 

             set          @fTasMer     =      (      SELECT tasa_mercado        --> rmnumdocu, rmcorrela, rmnumoper, rminstser, tasa_mercado
                                                            FROM   dbo.valorizacion_mercado
                                                            WHERE  fecha_valorizacion  = '2016-03-31'
                                                            AND          tipo_operacion             = case       when @rscartera = 111 then 'CP'
                                                                                                                         when @rscartera = 114 then 'VI'
                                                                                                                         when @rscartera = 159 then 'VI'
                                                                                                                  end
                                                            and          rmnumdocu                  = @rsnumdocu
                                                            and          rmcorrela                  = @rscorrela
                                                            and          rmnumoper                  = @rsnumoper
                                                      )

             if (@crscartera = 114)
             begin
                    if (@fTir <> @fTasMer) and (@dFecComp <= '2016-03-31')
                    begin
                           select 'Papel tiene una tasa distinta.' , @cMascara, ltrim(rtrim( @fTir )), ltrim(rtrim( @fTasMer ))
                           set @fTir = @fTasMer
                    end
                    
             end

             delete dbo.tmp_chkinstser_regulariza

             insert into dbo.tmp_chkinstser_regulariza
             execute dbo.SP_CHKINSTSER_upd @cMascara

             select @nCodigo     = Codigo
                    ,      @cMascara    = Mascara
                    ,      @nMonemi     = Monemi
                    ,      @cFecven     = convert(char(10),FecVen, 112)
                    ,      @fTasemi     = TasEmi
                    ,      @fBasemi     = BasEmi
                    ,      @fTasest     = 0.0
             from   dbo.tmp_chkinstser_regulariza 

             --     valor de compra
             set    @frsvalcomp         = 0.0
             set @frsvalcomu            = 0.0
             set @fMT                   = 0
             set @cFeccal        = convert(char(10), '2016-04-01', 112)

             Execute dbo.SP_VALORIZAR_CLIENT_upd 
                                                                          @nModo
                                                                   ,      @cFeccal
                                                                   ,      @nCodigo
                                                                   ,      @cMascara
                                                                   ,      @nMonemi
                                                                   ,      @cFecemi
                                                                   ,      @cFecven
                                                                   ,      @fTasemi
                                                                   ,      @fBasemi
                                                                   ,      @fTasest 
                                                                   ,      @fNominal
                                                                   ,      @fTir
                                                                   ,      @fPvp
                                                                   ,      @fMT         output
                                                                   ,      @fMTum       output

             set    @frsvalcomp         = @fMT
             set @frsvalcomu            = @fMTum
             --     valor de compra

             --     valor presente 
             set @frsvppresen    = 0.0
             set @fMT                   = 0
             set @cFeccal        = convert(char(10), @acfecproc, 112)

             Execute dbo.SP_VALORIZAR_CLIENT_upd 
                                                                          @nModo
                                                                   ,      @cFeccal
                                                                   ,      @nCodigo
                                                                   ,      @cMascara
                                                                   ,      @nMonemi
                                                                   ,      @cFecemi
                                                                   ,      @cFecven
                                                                   ,      @fTasemi
                                                                   ,      @fBasemi
                                                                   ,      @fTasest 
                                                                   ,      @fNominal
                                                                   ,      @fTir
                                                                   ,      @fPvp
                                                                   ,      @fMT         output
                                                                   ,      @fMTum       output
             set @frsvppresen    = @fMT
             
             --     valor presente proximo
             set @fMT                   = 0
             set @cFeccal        = convert(char(10), @acfecprox, 112)

             Execute dbo.SP_VALORIZAR_CLIENT_upd @nModo
                                                                   ,      @cFeccal
                                                                   ,      @nCodigo
                                                                   ,      @cMascara
                                                                   ,      @nMonemi
                                                                   ,      @cFecemi
                                                                   ,      @cFecven
                                                                   ,      @fTasemi
                                                                   ,      @fBasemi
                                                                   ,      @fTasest 
                                                                   ,      @fNominal
                                                                   ,      @fTir
                                                                   ,      @fPvp
                                                                   ,      @fMT         output
                                                                   ,      @fMTum       output

             set @frsvppresenx   = @fMT
             --     valor presente proximo

             --     reajustes
        if ( @nMonemi <> 999 and @nMonemi <> 13 )
        begin
            if @nCodigo <> 800
            begin
                select  @fValmon_Hoy = vmvalor from VIEW_VALOR_MONEDA where vmcodigo = @nMonemi AND vmfecha = @acfecproc
                select  @fValmon_Man = vmvalor from VIEW_VALOR_MONEDA where vmcodigo = @nMonemi AND vmfecha = @acfecprox
                           set     @rsReajuste  = round((@fValmon_Man - @fValmon_Hoy) * @frsvalcomu, 4)
            end else
            begin
                           set          @rsReajuste  = 0.0 --> @rsReajuste
            end
        end

             --     intereses
             set @rsInteres = @frsvppresenx - @frsvppresen - @rsReajuste

             --     actualizacion
             update #tmp_mdrs
                    set    xTir                = @fTir
                    ,      xValorPresente      = @frsvppresen
                    ,      xValorPresenteX     = @frsvppresenx
                    ,      xInteres            = @rsInteres
                    ,      xRsValComp          = @frsvalcomp
                    ,      xRsValComu          = @frsvalcomu
                    ,      xReajuste           = @rsReajuste
             where  Registro            = @nFila

             set @nFila = @nFila + 1
       end 

       select rsfecha
             ,      rsnumdocu
             ,      rscorrela
             ,      rsnumoper
             ,      rscartera
             ,      rstipoper
             ,      rsinstser
             ,      rsnominal
             ,      rstir
             ,      rsvalcomp
             ,      xRsValComp
             ,      rsvalcomu
             ,      xRsValComu
             ,      rsvppresen
             ,      xValorPresente
             ,      rsvppresenx
             ,      xValorPresenteX
             ,		vi.vivptirc
             
             ,      xValorPresenteX-vi.vivptirc AS diferencia_real
             

             /*
             ,      rsinteres
             ,      xInteres
             ,      rsreajuste
             ,      xReajuste
             */
             
       from   #tmp_mdrs r
       INNER JOIN mdvi vi ON vi.vinumdocu = r.rsnumdocu AND vi.vinumoper = r.rsnumoper AND vi.vicorrela = r.rscorrela  
       where  rstipoper = 'DEV'

/*
       if (@crscartera = 114)
       begin
		   select rsfecha
				 ,      rsnumdocu
				 ,      rscorrela
				 ,      rsnumoper
				 ,      rscartera
				 ,      rstipoper
				 ,      rsinstser
				 ,      rsnominal
				 ,      rstir
				 ,      rsvppresen
				 ,      xValorPresente
				 ,      rsvppresenx
				 ,      xValorPresenteX
				 ,      rsvalcomp
				 ,      xRsValComp
				 ,      rsvalcomu
				 ,      xRsValComu
				 ,      rsreajuste 
				 ,      rsinteres
				 ,      xInteres
		   from   #tmp_mdrs

       end
	   */
       if (@crscartera = 159)
       begin
             select rsfecha
                    ,      rsnumdocu
                    ,      rscorrela
                    ,      rsnumoper
                    ,      rscartera
                    ,      rstipoper
                    ,      rsinstser
                    ,      rsnominal
                    ,      rstir
                    ,      cptircomp
                    ,      ditircomp
                    ,      rsvalcomp
                    ,      cpvalcomp
                    ,      xRsValComp
                    ,      rsvalcomu
                    ,      cpvalcomu
                    ,      xRsValComu
                    ,      rsvppresen
                    ,      xValorPresente
                    ,      rsvppresenx
                    ,      xValorPresenteX
                    ,      rsinteres
                    ,      xInteres
                    ,      rsreajuste
                    ,      xReajuste
             from   #tmp_mdrs
                           inner join BacTraderSuda.dbo.Mdcp on cpnumdocu = rsnumdocu
                                                                                       and cpcorrela = rscorrela
                           inner join BacTradersuda.dbo.mddi on dinumdocu = rsnumdocu
                                                                                       and dicorrela   = rscorrela
             where  rstipoper = 'DEV'
       end
/*             
       select rsfecha
             ,      rsnumdocu
             ,      rscorrela
             ,      rsnumoper
             ,      rscartera
             ,      rstipoper
             ,      rsinstser
             ,      rsnominal
             ,      rstir
             ,      rsvppresen
             ,      xValorPresente
             ,      rsvppresenx
             ,      xValorPresenteX
             ,      rsvalcomp
             ,      xRsValComp
             ,      rsvalcomu
             ,      xRsValComu
             ,      rsreajuste 
             ,      rsinteres
             ,      xInteres
       from   #tmp_mdrs
       where  abs(rsvppresen  - xValorPresente)  > 5
             or     abs(rsvppresenx - xValorPresenteX) > 5
*/             
end
GO
