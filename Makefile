
formats=html pdf

src:=$(wildcard book/*.asciidoc)
srcroot = book/book.asciidoc

asciidoctor_plugins=pdf diagram rouge

asciidoctor_opts=\
  --doctype=book \
	--source-dir=book --destination-dir=$(dir $@) \
	$(asciidoctor_plugins:%=--require=asciidoctor-%)


all: $(formats)
$(foreach f,$(formats),$(eval $f: out/$f/book.$f;))

out/%: $(src) | $(dir $@)/
	asciidoctor $(asciidoctor_opts) --backend=$(subst .,,$(suffix $@)) $(srcroot)

%/:
	mkdir -p $@

clean:
	rm -rf out/

.PHONY: all html pdf continually clean
