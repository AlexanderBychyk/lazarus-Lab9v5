unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, PopupNotifier;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    PopupNotifier1: TPopupNotifier;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  f: TextFile;
  str, savedtext: string;
  i,j,n,k,count,buf: integer;
  letter: char;
implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.Memo1Change(Sender: TObject);
begin
  if (Memo1.GetTextLen() > 0) then begin
    Button1.Enabled := true;    
    Button3.Enabled := true;
  end else begin
    Button1.Enabled := false;
    Button3.Enabled := false;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if (saveDialog1.Execute) then begin
    assignFile(f,saveDialog1.FileName);
    StatusBar1.Panels[0].Text := saveDialog1.FileName;
    rewrite(f);
    str := Memo1.Text;
    write(f, str);
    closeFile(f);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if (openDialog1.Execute) then begin
    assignFile(f,openDialog1.fileName);
    StatusBar1.Panels[0].Text := openDialog1.fileName;
    reSet(f); 
    Memo1.Lines.LoadFromFile(openDialog1.fileName);
    closeFile(f);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if (labeledEdit1.text = '') then begin
    PopupNotifier1.ShowAtPos(left+GroupBox2.Left, top+button3.Top+50);
  end
  else begin
    str := StringReplace(Memo1.Text, #10, ' ', [rfReplaceAll]);

    letter := LabeledEdit1.text[1];
    buf:=0;
    count:=0;

    i:=1;
    while i<=length(str) do begin
      if (str[i]=letter) then begin
        while (str[i]=letter) do begin
          count:=count+1;
          i:=i+1;
        end;
        if (buf < count) then buf:=count;
        count:=0;
      end;
      i:=i+1;
    end;

    //for i:=1 to length(str) do begin
    //  if (letter=str[i]) then begin
    //    x:=x+1;
    //  end else begin
    //    if (count < x) then begin
    //      count := x;
    //    end;
    //    x := 1;
    //  end;
    //end;

    //for i:=Pos(str, letter) to length(str) do begin
    //  if (letter=str[i]) then begin
    //    x:=x+1;
    //  end else begin
    //    if (count < x) then begin
    //      count := x;
    //    end;
    //    x := 1;
    //  end;
    //end;
    //end;

    LabeledEdit2.Text := intToStr(buf);
  end;
end;

end.

