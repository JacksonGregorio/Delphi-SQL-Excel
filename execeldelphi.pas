unit execeldelphi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.win.ComObj;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    ProgressBar1: TProgressBar;
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    DataSource1: TDataSource;
    FDQuery1: TFDQuery;
    FDQuery1id: TFDAutoIncField;
    FDQuery1nome: TStringField;
    FDQuery1numero: TStringField;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unit2;

procedure TForm1.BitBtn1Click(Sender: TObject);
var planilha : variant;
    linha, contar : integer ;
begin
            contar := FDQuery1.RecordCount;
            ProgressBar1.Max := contar;
            ProgressBar1.Position := 0;
            FDQuery1.Filtered := false;
            linha := 2;

            planilha := CreateOleObject('Excel.Application');
            planilha.caption := 'Exporte para Execel';
            planilha.workbooks.add(1);

            planilha.Cells[1,1] := 'id';
            planilha.Cells[1,2] := 'nome';
            planilha.Cells[1,3] := 'numero';

            FDQuery1.DisableControls;

            try
              while not FDQuery1.Eof do
              begin
              planilha.cells[linha, 1] := FDQuery1id.value;
              planilha.cells[linha, 2] := FDQuery1nome.Value;
              planilha.cells[linha, 3] := FDQuery1numero.value;
              linha := linha +1;
              FDQuery1.Next;
              ProgressBar1.Position := ProgressBar1.Position + 1;
              end;
              Planilha.Columns.autofit;
              Planilha.visible := true;

            finally
              FDQuery1.EnableControls;
              planilha := unassigned;

            end;




end;



end.
