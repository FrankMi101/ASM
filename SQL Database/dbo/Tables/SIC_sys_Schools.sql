CREATE TABLE [dbo].[SIC_sys_Schools] (
    [IDs]               INT           IDENTITY (1, 1) NOT NULL,
    [School_code]       VARCHAR (8)   NOT NULL,
    [School_bsid]       VARCHAR (13)  NOT NULL,
    [school_name]       VARCHAR (150) NOT NULL,
    [school_brief_name] VARCHAR (50)  NOT NULL,
    [default_adminID]   VARCHAR (30)  NULL,
    [school_area]       VARCHAR (20)  NULL,
    [active_flag]       VARCHAR (1)   NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [SIC_sys_Schools_index]
    ON [dbo].[SIC_sys_Schools]([School_code] ASC);

