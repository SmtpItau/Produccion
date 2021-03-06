USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTRATO01]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTRATO01]
       (
        @nnumoper   NUMERIC(10)        -- Nomero de Operaci«n
       )
AS
BEGIN
   
   SET NOCOUNT ON
   SELECT       'BANCO1' = acnomprop,
                'SUCURS' = sudescr,
                'DIREC1' = acdirprop,
                'RUTBC1' = RTRIM( CONVERT( CHAR(09), acrutprop ) ) + '-' +
                           acdigprop,
                'NUMOPE' = canumoper,
                'FECOPE' = CONVERT( CHAR(10), cafecha, 103 ),
                'TELEF1' = '',
                'FAX1'   = '',
                'BANCO2' = cl.clnombre,
                'RUTBC2' = RTRIM( CONVERT( CHAR(09), clrut ) ) + '-' + cldv,
                'DIREC2' = cl.cldirecc,
                'TELEF2' = cl.clfono,
                'FAX2'   = cl.clfax,
                'TIPOPE' = catipoper,
                'FECOPE' = CONVERT( CHAR(10), cafecha, 103 ),
                'HOROPE' = '',
                'FECVTO' = CONVERT( CHAR(10), cafecvcto, 103 ),
                'MODALI' = catipmoda,
                'MDAORI' = mdaori.mnnemo,
                'MTOORI' = camtomon1,
                'GLOSA1' = '',
                'TIPCAM' = catipcam,
                'PARUSD' = 1,
                'PARUSD' = 'N/A',
                'MDACNV' = mdacnv.mnnemo,
                'MTOCNV' = camtomon2,
                'GLOSA2' = '',
                'MDAUSD' = mdaref.mnglosa,
                'PARCNV' = 'N/A',
                'LUGVTO' = tbglosa,
                'OTRCON' = '',
                'NOMAP1' = '',
                'RUTAP1' = '',
                'NOMAP2' = '',
                'RUTAP2' = '',
                'NOMAP3' = '',
                'RUTAP3' = '',
                'NOMAP4' = '',
                'RUTAP4' = ''
          FROM  MFCA, 
                MFAC,
                MDSU,
                VIEW_CLIENTE cl,
                VIEW_MONEDA mdaori,
                VIEW_MONEDA mdacnv,
                VIEW_MONEDA mdaref,
                VIEW_TABLA_GENERAL_DETALLE a
          WHERE canumoper  = @nnumoper       AND
                acsucmesa  = sucodsuc        AND
                cacodigo   = cl.clrut           AND
                cacodmon1  = mdaori.mncodmon AND
                cacodmon2  = mdacnv.mncodmon AND
                camdausd   = mdaref.mncodmon AND
                cl.clciudad   = convert(numeric(6),a.tbcodigo1) --     AND
   SET NOCOUNT OFF
END

GO
