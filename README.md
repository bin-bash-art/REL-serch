# My Script Runner

このプロジェクトは、スクリプトを実行し、その結果をログに記録するためのものです。 

## 概要

My Script Runnerは、システム管理者やITエンジニアのための便利なツールです。様々なシェルコマンドをメニュー形式で簡単に実行し、その結果を自動的にログファイルに記録します。定期的なシステムチェックやサーバーメンテナンス作業を効率化するために設計されています。

## 特徴

- **使いやすいメニューインターフェース**: 利用可能なスクリプトを一覧表示し、番号で簡単に選択できます
- **複数スクリプトの連続実行**: 複数のスクリプトを一度に指定して実行できます
- **自動ログ記録**: すべての実行結果は日時付きのログファイルに自動保存されます
- **拡張性**: 新しいスクリプトを簡単に追加できる設計になっています
- **整理されたディレクトリ構造**: スクリプトとログが整理されたディレクトリ構造で管理されます

## ディレクトリ構造

```
my-script-runner/
├── script_menu.sh    # メインメニュースクリプト
├── call/             # 実行可能なスクリプトを格納するディレクトリ
│   ├── 01.sh         # 各種スクリプト
│   ├── 02.sh
│   └── ...
└── log/              # 実行結果のログが保存されるディレクトリ
```

## 使い方

1. リポジトリをクローンします:
   ```
   git clone https://github.com/yourusername/my-script-runner.git
   cd my-script-runner
   ```

2. メインスクリプトを実行します:
   ```
   bash script_menu.sh
   ```

3. 表示されるメニューから実行したいスクリプト番号を入力します。複数のスクリプトを実行する場合は、スペースで区切って番号を入力します（例: `1 2 3`）。

4. 実行結果は画面に表示されると同時に、`log/`ディレクトリ内のファイルに保存されます。

## 新しいスクリプトの追加方法

1. `call/`ディレクトリに新しいスクリプトファイルを作成します（例: `46.sh`）
2. スクリプトの先頭に以下の形式でコメントを追加します:
   ```bash
   #!/bin/bash
   # スクリプトの説明（メニューに表示されます）
   ```
3. スクリプトの内容を記述します。基本的なテンプレートは以下の通りです:
   ```bash
   script_dir="$(dirname "$0")"
   base_dir="$(dirname "$script_dir")"
   log_dir="$base_dir/log"

   mkdir -p "$log_dir"

   command="実行したいコマンド"
   safe_command_name=$(echo "$command" | tr -c 'a-zA-Z0-9_-' '_')
   output_file="$log_dir/output_${safe_command_name}_$(date +%Y%m%d_%H%M%S).txt"

   echo "Command: $command" | tee -a "$output_file"
   $command | tee -a "$output_file"
   echo "Execution result saved to $output_file."
   ```

## 要件

- Bash シェル環境
- 基本的な Unix/Linux コマンド

## Lisence

This project is licensed under the MIT License, see the LICENSE.txt file for details

## 貢献

バグ報告や機能リクエストは、GitHubのIssueを通じてお知らせください。プルリクエストも歓迎します。

## 作者
bin-bash-art