class ApiController < ApplicationController
	# hashized
	#############################
  def hashnized
		
		@res = {
						:status => true,
						:text => nil,
						:hashnized => nil 
					 }

		text = params[:text] || "" 
		
		items = indexed text
		hashnized = tagged text, items

		@res[:text] = text
		@res[:hashnized] = hashnized

		respond_to do |format|
			format.json { render :json => @res ,:callback => params[:callback] }
		end
  end

private
	# tagged
	##################################
	def tagged text, items
		items.each do |item|
			next if /\##{item}/ =~ text
			text = text.gsub(/#{item}/,"\s##{item}\s")
		end

		text = text.gsub(/^\s/, "")
		text = text.gsub(/\s\s/, "\s")
		text = text.gsub(/\s$/, "")
		

		return text
	end

	# indexed
	##################################
	def indexed text
		res = []
		indexedtext = ""

		mecab = MeCab::Tagger.new()
		nlp = mecab.parse text

		nlp.split("\n").each do |line|
			break if /EOS/ =~ line
			
			items = line.split(/(\t|,)/)
			
			word = items[0]
			hinshi = items[2]
			katsuyo1 = items[4]
			katsuyo2 = items[6]			

			# フレーズ合成アルゴリズム
			#####################################
			if /^\#$/ =~ word then
      	# 既にハッシュタグがある場合
          indexedtext += word.to_s

      elsif (/^[0-9a-zA-Z]+$/ =~ word or /ー/ =~ word or /\// =~ word or /^[ぁ-ん]$/ =~ word or /^[ァ-ヴ]$/ =~ word) then
        # 英数字のみ、伸ばし棒、スラッシュ、ひらがなかたかな１文字（フレーズに該当しない）
         indexedtext += "/"

      elsif hinshi == "名詞" then
        # 名詞である場合
         indexedtext += word.to_s

      elsif hinshi == "形容詞" and katsuyo1 == "*" and katsuyo2 == "*" then
        # 形容詞である場合
         indexedtext += word.to_s

      else
        # その他(フレーズに該当しない)
          indexedtext += "/"
      end
		end
	
		_res = indexedtext.split(/\/+/)
		_res.each do |r|
			if !(/^\#/ =~ r) and r.size > 1 
				res.push r
			end
		end

		return res
	end
end
